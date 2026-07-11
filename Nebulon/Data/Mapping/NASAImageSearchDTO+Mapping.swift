import Foundation

extension NASAImageSearchDTO {

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
        guard let data = data.first else { return nil }

        let imageLinks = (links ?? []).filter { $0.render == "image" }

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


    private static func bestDetailLink(
        from links: [NASAImageSearchDTO.ItemLinkDTO],
        maxWidth: Int = 2400
    ) -> NASAImageSearchDTO.ItemLinkDTO? {
        let renditions = links.filter {
            $0.rel != "preview" && !$0.href.lowercased().hasSuffix(".tif")
        }
        let capped = renditions.filter { ($0.width ?? .max) <= maxWidth }

        return capped.max { ($0.width ?? 0) < ($1.width ?? 0) }
            ?? renditions.min { ($0.width ?? .max) < ($1.width ?? .max) }
    }

    private static func url(from href: String) -> URL? {
        URL(string: href, encodingInvalidCharacters: true)
    }

    private static let dateFormatter = ISO8601DateFormatter()
}
