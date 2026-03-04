import Foundation

enum APIConfig {
    // Reads from Info.plist which reads from .xcconfig
    // App will crash on launch if key is missing — good, fail fast
    // TODO: - Error handling
    static let nasaKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "NASA_API_KEY") as? String,
              !key.isEmpty else {
            fatalError("NASA_API_KEY missing from Info.plist — check your .xcconfig")
        }
        return key
    }()

    static let nasaBaseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "NASA_BASE_URL") as? String,
              !url.isEmpty else {
            fatalError("NASA_BASE_URL missing from Info.plist — check your .xcconfig")
        }
        return url
    }()
}
