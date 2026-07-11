import Foundation

struct ImagePreloader {

    static func isCached(url: URL) -> Bool {
        let request = URLRequest(url: url)
        return ImageCache.cache.cachedResponse(for: request) != nil
    }

    static func preload(url: URL) async -> Bool {
        let request = URLRequest(url: url)

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
