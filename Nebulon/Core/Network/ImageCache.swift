// Core/Network/ImageCache.swift

import Foundation

final class ImageCache {
    static let cache = URLCache(
        memoryCapacity: 50 * 1024 * 1024,   // 50MB memory
        diskCapacity: 200 * 1024 * 1024,     // 200MB disk
        diskPath: "nebulon_image_cache"
    )

    /// A URLSession wired to our custom cache
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()
}
