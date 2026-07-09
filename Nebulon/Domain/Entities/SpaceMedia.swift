// Domain/Entities/SpaceMedia.swift

// A single result from the NASA Image and Video Library.
// Driven by app needs, not API shape — the DTO flattens the API's
// nested collection/items/data/links structure into this.

import Foundation

struct SpaceMedia: Identifiable, Hashable {
    /// NASA's own stable identifier (e.g. "PIA04227")
    let id: String

    let title: String
    let description: String?
    let dateCreated: Date?

    /// NASA center that produced the media (e.g. "JPL", "GSFC")
    let center: String?
    let keywords: [String]
    let photographer: String?

    /// Small rendition — for grid cells
    let thumbnailURL: URL?
    /// Best available rendition — for the detail screen
    let imageURL: URL?
}

/// One page of search results — carries what pagination needs and nothing more
struct SpaceMediaPage: Hashable {
    let items: [SpaceMedia]
    let totalHits: Int
}
