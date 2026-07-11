import Foundation

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        print("🌐 Fetching: \(url.host() ?? "")\(url.path())")
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }

            return try decoder.decode(T.self, from: data)

        } catch let error as NetworkError {
            throw error
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
