// Data/Network/DTOs/APODDTO.swift
import Foundation

// DTO = Data Transfer Object
// Its ONLY job: match the JSON shape exactly and decode it
// Lives in Data — JSON is a Data concern, Domain doesn't care about JSON

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
    let mediaType: String       // JSON: "media_type" → Swift: mediaType (convertFromSnakeCase)
    let serviceVersion: String  // JSON: "service_version"
    let title: String
    let url: String
    let copyright: String?      // Optional — not all APODs have a copyright holder

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
