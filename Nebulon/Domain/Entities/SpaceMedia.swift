import Foundation

struct SpaceMedia: Identifiable, Hashable {
    let id: String

    let title: String
    let description: String?
    let dateCreated: Date?

    let center: String?
    let keywords: [String]
    let photographer: String?

    let thumbnailURL: URL?
    let imageURL: URL?
}
