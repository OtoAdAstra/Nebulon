// Lives in Core — pure infrastructure, knows nothing about NASA or APOD
// Depends only on Endpoint protocol (also Core) and URLSession (Apple)
// Injected into repositories via protocol — testable

import Foundation

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        // convertFromSnakeCase means:
        // JSON "media_type" → Swift property "mediaType" automatically
    }

    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        // 1. Build URL from endpoint pieces
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        print("🌐 Fetching: \(url)")
        
        // 2. Build the request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        do {
            // 3. Make the network call — await suspends here until response arrives
            let (data, response) = try await session.data(for: request)

            // 4. Validate HTTP status code
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }

            // 5. Decode — T is whatever the caller expects
            // decoder knows how to decode T because T: Decodable
            return try decoder.decode(T.self, from: data)

        } catch let error as NetworkError {
            throw error // already our type, rethrow as-is
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
