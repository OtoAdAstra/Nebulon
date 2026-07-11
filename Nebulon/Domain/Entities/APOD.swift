struct APOD: Identifiable, Hashable, Codable {
    var id: String { date }

    let date: String
    let explanation: String
    let mediaType: String
    let title: String
    let url: String
    let copyright: String?

    var isVideo: Bool {
        mediaType == "video"
    }

    var isImage: Bool {
        mediaType == "image"
    }
}
