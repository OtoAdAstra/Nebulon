// Domain/Entities/APOD.swift

// The purest layer — zero external dependencies
// No import Foundation needed ideally
// Driven by app needs, not API shape
// Shared across all features that need APOD data

struct APOD: Identifiable, Hashable, Codable {
    // Computed — domain decides what the ID is, not the API
    var id: String { date }

    let date: String
    let explanation: String
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String

    // Domain logic lives here — not in ViewModel, not in View
    var isVideo: Bool {
        mediaType == "video"
    }

    var isImage: Bool {
        mediaType == "image"
    }
}
