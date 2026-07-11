import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}
