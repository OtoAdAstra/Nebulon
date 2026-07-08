import Foundation

enum NASAImageLibraryEndpoint: Endpoint {
    case search(query: String, page: Int, pageSize: Int)

    var baseURL: String {
        APIConfig.nasaImagesBaseURL
    }

    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let query, let page, let pageSize):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "media_type", value: "image"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "page_size", value: "\(pageSize)"),
            ]
        }
    }

    var method: HTTPMethod { .get }
}
