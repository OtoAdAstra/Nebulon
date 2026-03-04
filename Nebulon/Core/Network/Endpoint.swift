import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var url: URL? {
        let base = baseURL.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        var components = URLComponents(string: base + path)
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        return components?.url
    }
}
