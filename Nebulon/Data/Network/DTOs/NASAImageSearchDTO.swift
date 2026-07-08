import Foundation

// The API wraps results in a Collection+JSON envelope:
// {
//   "collection": {
//     "items": [
//       {
//         "data":  [{ "nasa_id": "...", "title": "...", "date_created": "..." }],
//         "links": [{ "href": "...~thumb.jpg", "rel": "preview", "render": "image" }]
//       }
//     ],
//     "metadata": { "total_hits": 12345 }
//   }
// }
// snake_case keys become camelCase via the decoder's convertFromSnakeCase.

struct NASAImageSearchDTO: Decodable {
    let collection: CollectionDTO

    struct CollectionDTO: Decodable {
        let items: [ItemDTO]
        let metadata: MetadataDTO?
    }

    struct MetadataDTO: Decodable {
        let totalHits: Int
    }

    struct ItemDTO: Decodable {
        let data: [ItemDataDTO]
        let links: [ItemLinkDTO]?
    }

    struct ItemDataDTO: Decodable {
        let nasaId: String
        let title: String
        let description: String?
        let dateCreated: String?
        let center: String?
        let keywords: [String]?
        let mediaType: String
        let photographer: String?
    }

    struct ItemLinkDTO: Decodable {
        let href: String
        let rel: String      // "preview" (thumb), "alternate" (small/medium), "canonical" (original)
        let render: String?  // "image" — absent for caption/metadata links
        let width: Int?      // pixel width of this rendition, when the API provides it
    }
}

// MARK: - Mapping

extension NASAImageSearchDTO {

    /// Flattens the Collection+JSON envelope into clean Domain types.
    func toDomain() -> SpaceMediaPage {
        let items = collection.items.compactMap { $0.toDomain() }
        return SpaceMediaPage(
            items: items,
            totalHits: collection.metadata?.totalHits ?? items.count
        )
    }
}

extension NASAImageSearchDTO.ItemDTO {

    func toDomain() -> SpaceMedia? {
        // The "data" array virtually always has exactly one element
        guard let data = data.first else { return nil }

        let imageLinks = (links ?? []).filter { $0.render == "image" }

        // Photos only: drop videos/audio outright, and drop items that have
        // no displayable rendition — they'd show as an empty black cell
        guard data.mediaType == "image", !imageLinks.isEmpty else { return nil }

        let thumbnail = imageLinks.first { $0.rel == "preview" } ?? imageLinks.first
        let full = Self.bestDetailLink(from: imageLinks) ?? thumbnail

        return SpaceMedia(
            id: data.nasaId,
            title: data.title,
            description: data.description?.trimmingCharacters(in: .whitespacesAndNewlines),
            dateCreated: data.dateCreated.flatMap { Self.dateFormatter.date(from: $0) },
            center: data.center,
            keywords: data.keywords ?? [],
            photographer: data.photographer,
            thumbnailURL: thumbnail.flatMap { Self.url(from: $0.href) },
            imageURL: full.flatMap { Self.url(from: $0.href) }
        )
    }

    /// Detail-screen rendition: the largest non-original at most `maxWidth` wide.
    /// Originals (`~orig`) can be 50MB+ JPEGs or TIFFs that stall or fail to
    /// decode on device — the screen just stays black — so they are a last resort.
    private static func bestDetailLink(
        from links: [NASAImageSearchDTO.ItemLinkDTO],
        maxWidth: Int = 2400
    ) -> NASAImageSearchDTO.ItemLinkDTO? {
        let renditions = links.filter {
            $0.rel != "preview" && !$0.href.lowercased().hasSuffix(".tif")
        }
        let capped = renditions.filter { ($0.width ?? .max) <= maxWidth }

        return capped.max { ($0.width ?? 0) < ($1.width ?? 0) }          // biggest that fits
            ?? renditions.min { ($0.width ?? .max) < ($1.width ?? .max) } // else the smallest
    }

    /// Some asset hrefs contain spaces — encode them instead of dropping the item
    private static func url(from href: String) -> URL? {
        URL(string: href, encodingInvalidCharacters: true)
    }

    private static let dateFormatter = ISO8601DateFormatter()
}
