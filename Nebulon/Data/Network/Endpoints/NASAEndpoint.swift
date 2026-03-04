import Foundation

// Lives in Data — this knows about NASA specifically
// Core knows nothing about NASA, Data knows everything about it
// Conforms to Endpoint protocol from Core

enum NASAEndpoint: Endpoint {
    case apod                                    // today's APOD
    case apodByDate(date: String)                // specific date "2026-03-03"
    case marsPhotos(rover: String, sol: Int)

    // Reads from Core/Config — not hardcoded
    var baseURL: String {
        APIConfig.nasaBaseURL
    }

    var path: String {
        switch self {
        case .apod, .apodByDate:
            return "/planetary/apod"
        case .marsPhotos(let rover, _):
            return "/mars-photos/api/v1/rovers/\(rover)/photos"
        }
    }

    var queryItems: [URLQueryItem] {
        // API key goes on every request
        var items = [URLQueryItem(name: "api_key", value: APIConfig.nasaKey)]

        switch self {
        case .apod:
            break // no extra params, NASA returns today by default

        case .apodByDate(let date):
            // adds ?date=2026-03-03 to the URL
            items.append(URLQueryItem(name: "date", value: date))

        case .marsPhotos(_, let sol):
            items.append(URLQueryItem(name: "sol", value: "\(sol)"))
        }

        return items
    }

    var method: HTTPMethod { .get }
}
