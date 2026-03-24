// Core/Network/ImagePreloader.swift

// Preloads images into URLCache so views can display them instantly.
// Lives in Core — pure infrastructure, no domain knowledge.

import Foundation

struct ImagePreloader {

    /// Returns true if the image at `url` is already in the cache.
    static func isCached(url: URL) -> Bool {
        let request = URLRequest(url: url)
        return ImageCache.cache.cachedResponse(for: request) != nil
    }

    /// Downloads the image at `url` and stores it in the cache.
    /// Returns true if the image was successfully fetched (or was already cached).
    static func preload(url: URL) async -> Bool {
        let request = URLRequest(url: url)

        // Already cached — skip network
        if ImageCache.cache.cachedResponse(for: request) != nil {
            print("🖼️ Image already cached: \(url.lastPathComponent)")
            return true
        }

        print("🖼️ Image preload started: \(url.lastPathComponent)")
        do {
            let (data, response) = try await ImageCache.session.data(for: request)
            let cached = CachedURLResponse(response: response, data: data)
            ImageCache.cache.storeCachedResponse(cached, for: request)
            print("🖼️ Image preload finished: \(url.lastPathComponent) (\(data.count) bytes)")
            return true
        } catch {
            print("🖼️ Image preload failed: \(error.localizedDescription)")
            return false
        }
    }
}
