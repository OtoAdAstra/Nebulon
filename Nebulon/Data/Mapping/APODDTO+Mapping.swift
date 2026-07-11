import Foundation

extension APODDTO {

    func toDomain() -> APOD {
        APOD(
            date: date,
            explanation: explanation,
            mediaType: mediaType,
            title: title,
            url: url,
            copyright: copyright?.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }
}
