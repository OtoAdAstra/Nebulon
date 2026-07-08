import Foundation

enum APIConfig {
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

    static let nasaImagesBaseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "NASA_IMAGES_BASE_URL") as? String,
              !url.isEmpty else {
            fatalError("NASA_IMAGES_BASE_URL missing from Info.plist — check your .xcconfig")
        }
        return url
    }()
}
