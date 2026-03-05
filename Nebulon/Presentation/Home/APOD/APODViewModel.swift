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

    private let fetchAPODUseCase: FetchAPODUseCase
    private static let cachedAPODKey = "cachedAPOD"
    private var lastFetchHour: Int?

    init(fetchAPODUseCase: FetchAPODUseCase) {
        self.fetchAPODUseCase = fetchAPODUseCase

        // Restore cached APOD immediately — no loading flash
        if let data = UserDefaults.standard.data(forKey: Self.cachedAPODKey),
           let cached = try? JSONDecoder().decode(APOD.self, from: data) {
            self.apod = cached
            self.state = .loaded
        }
    }

    func onAppear() async {
        if apod == nil {
            await loadTodaysAPOD()
        } else if shouldRefresh {
            await refreshAPODSilently()
        }
    }

    private var shouldRefresh: Bool {
        guard let lastFetchHour else { return true }
        let currentHour = Calendar.current.component(.hour, from: Date())
        return currentHour != lastFetchHour
    }

    func loadAPOD(for date: String) async {
        await load { [self] in
            try await fetchAPODUseCase.execute(date: date)
        }
    }

    private func loadTodaysAPOD() async {
        await load { [self] in
            try await fetchAPODUseCase.execute()
        }
    }

    /// Fetches latest APOD without showing loading state — updates only if data changed
    private func refreshAPODSilently() async {
        do {
            let result = try await fetchAPODUseCase.execute()
            lastFetchHour = Calendar.current.component(.hour, from: Date())
            invalidateCacheIfNeeded(for: result)
            apod = result
            persistAPOD(result)
        } catch {
            // Silent refresh — keep showing cached data on failure
        }
    }

    // DRY helper — handles state transitions for any load operation
    private func load(_ operation: () async throws -> APOD) async {
        state = .loading
        do {
            let result = try await operation()
            lastFetchHour = Calendar.current.component(.hour, from: Date())
            invalidateCacheIfNeeded(for: result)
            apod = result
            persistAPOD(result)
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    private func persistAPOD(_ apod: APOD) {
        if let data = try? JSONEncoder().encode(apod) {
            UserDefaults.standard.set(data, forKey: Self.cachedAPODKey)
        }
    }

    private func invalidateCacheIfNeeded(for apod: APOD) {
        guard let lastCachedDate = UserDefaults.standard.string(forKey: "lastCachedAPODDate"),
              lastCachedDate != apod.date else {
            UserDefaults.standard.set(apod.date, forKey: "lastCachedAPODDate")
            return
        }
        // New APOD — clear old image cache
        ImageCache.cache.removeAllCachedResponses()
        UserDefaults.standard.set(apod.date, forKey: "lastCachedAPODDate")
    }
    
}

//MARK: - States
enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
}
