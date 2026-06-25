import Foundation

// The JSON response:
// {
//   "date": "2026-03-03",
//   "explanation": "If you could fly...",
//   "media_type": "video",        ← snake_case, becomes mediaType via decoder
//   "service_version": "v1",      ← becomes serviceVersion
//   "title": "Flying over...",
//   "url": "https://..."
// }

struct APODDTO: Decodable {
    let date: String
    let explanation: String
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String
    let copyright: String?

    // Converts raw DTO into clean Domain entity
    // This is the bridge between Data and Domain layers
    func toDomain() -> APOD {
        APOD(
            date: date,
            explanation: explanation,
            mediaType: mediaType,
            title: title,
            url: url,
            copyright: copyright?.trimmingCharacters(in: .whitespacesAndNewlines)
            // serviceVersion dropped — Domain doesn't care about API versioning
        )
    }
}
