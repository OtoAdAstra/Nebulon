protocol NetworkClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
