// Presentation/APOD/APODViewModel.swift

// Knows about: UseCase (Domain), APOD entity (Domain)
// Knows nothing about: networking, JSON, URLSession
// Owns UI state — loading, loaded, error

import Foundation

@MainActor
@Observable
final class APODViewModel {

    private(set) var apod: APOD?
    private(set) var state: ViewState = .idle

    var isFullyLoaded: Bool {
        state == .loaded
    }

    private let fetchAPODUseCase: FetchAPODUseCaseProtocol
    private static let cachedAPODKey = "cachedAPOD"
    private static let cachedAPODDateKey = "lastCachedAPODDate"

    init(fetchAPODUseCase: FetchAPODUseCaseProtocol) {
        self.fetchAPODUseCase = fetchAPODUseCase

        // Restore cached APOD immediately — no loading flash
        if let data = UserDefaults.standard.data(forKey: Self.cachedAPODKey),
           let cached = try? JSONDecoder().decode(APOD.self, from: data) {
            self.apod = cached
            print("📦 Restored cached APOD: \"\(cached.title)\" (\(cached.date))")

            // Check if media is already ready
            if cached.isVideo {
                self.state = .loaded
                print("📦 Video type — no image preload needed")
            } else if let url = URL(string: cached.url), ImagePreloader.isCached(url: url) {
                self.state = .loaded
                print("📦 Image cache hit — fully loaded")
            } else {
                self.state = .dataLoaded
                print("📦 Image not cached — will preload")
            }
        } else {
            print("📦 No cached APOD found — will fetch from network")
        }
    }

    func onAppear() async {
        if apod == nil {
            print("🔄 onAppear: No APOD data — fetching from network")
            await loadTodaysAPOD()
        } else if shouldRefresh {
            print("🔄 onAppear: Cached APOD is stale — refreshing silently")
            await refreshAPODSilently()
        } else {
            print("🔄 onAppear: Cached APOD is fresh — skipping fetch")
            // Image might not be cached if app was relaunched
            if state == .dataLoaded, let apod {
                await preloadImage(for: apod)
            }
        }
    }

    /// APOD changes once per day — refresh only if the cached date is not today
    private var shouldRefresh: Bool {
        guard let cachedDate = UserDefaults.standard.string(forKey: Self.cachedAPODDateKey) else {
            return true
        }
        let today = Self.todayDateString()
        let isStale = cachedDate != today
        print("🔄 shouldRefresh: cached=\(cachedDate) today=\(today) → \(isStale ? "yes" : "no")")
        return isStale
    }

    private func loadTodaysAPOD() async {
        await load {
            try await fetchAPODUseCase.execute()
        }
    }

    /// Fetches latest APOD without showing loading state — updates only if data changed
    private func refreshAPODSilently() async {
        print("🔇 Silent refresh started")
        do {
            let result = try await fetchAPODUseCase.execute()
            print("🔇 Silent refresh got: \"\(result.title)\" (\(result.date))")

            let isNewAPOD = result.date != apod?.date
            if isNewAPOD {
                print("🔇 New APOD detected — clearing old image cache")
                ImageCache.cache.removeAllCachedResponses()
                state = .dataLoaded
            }

            apod = result
            persistAPOD(result)

            if isNewAPOD || state != .loaded {
                await preloadImage(for: result)
            }
        } catch {
            print("🔇 Silent refresh failed: \(error.localizedDescription) — keeping cached data")
        }
    }

    // DRY helper — handles state transitions for any load operation
    private func load(_ operation: () async throws -> APOD) async {
        state = .loading
        print("⏳ Load started — state → .loading")
        do {
            let result = try await operation()
            print("✅ API fetch succeeded: \"\(result.title)\" (\(result.date))")

            invalidateImageCacheIfNeeded(for: result)
            apod = result
            state = .dataLoaded
            persistAPOD(result)
            await preloadImage(for: result)
            print("✅ Load complete — state → .loaded")
        } catch {
            state = .error(error.localizedDescription)
            print("❌ Load failed — state → .error: \(error.localizedDescription)")
        }
    }

    private func preloadImage(for apod: APOD) async {
        guard !apod.isVideo, let url = URL(string: apod.url) else {
            state = .loaded
            print("🖼️ No image to preload (video or invalid URL)")
            return
        }
        if await ImagePreloader.preload(url: url) {
            state = .loaded
        }
    }

    private func persistAPOD(_ apod: APOD) {
        if let data = try? JSONEncoder().encode(apod) {
            UserDefaults.standard.set(data, forKey: Self.cachedAPODKey)
            UserDefaults.standard.set(apod.date, forKey: Self.cachedAPODDateKey)
            print("💾 Persisted APOD to cache (\(apod.date))")
        }
    }

    /// Clears the image cache if the APOD has changed (new date = new image)
    private func invalidateImageCacheIfNeeded(for newAPOD: APOD) {
        let lastCachedDate = UserDefaults.standard.string(forKey: Self.cachedAPODDateKey)
        if lastCachedDate != nil && lastCachedDate != newAPOD.date {
            ImageCache.cache.removeAllCachedResponses()
            print("🗑️ Image cache cleared — APOD date changed from \(lastCachedDate!) to \(newAPOD.date)")
        }
    }

    private static func todayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "America/New_York") // NASA uses ET
        return formatter.string(from: Date())
    }
}

//MARK: - States
enum ViewState: Equatable {
    case idle
    case loading
    case dataLoaded
    case loaded
    case error(String)
}
