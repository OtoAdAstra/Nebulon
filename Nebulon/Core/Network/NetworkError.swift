// Lives in Core because NetworkClient throws these
// Data layer catches and potentially re-throws them
// Domain never sees these — Domain uses its own errors if needed

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case badResponse(statusCode: Int)
    case noData
    case decodingFailed(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL was invalid."
        case .badResponse(let code):
            return "Bad server response: \(code)"
        case .noData:
            return "No data received."
        case .decodingFailed(let error):
            return "Failed to decode: \(error.localizedDescription)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
