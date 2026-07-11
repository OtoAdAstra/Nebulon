import Foundation

extension Endpoint {
    var url: URL? {
        let base = baseURL.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        var components = URLComponents(string: base + path)
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        return components?.url
    }
}
