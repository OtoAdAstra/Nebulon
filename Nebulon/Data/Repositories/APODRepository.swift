// Knows about: NetworkClient (Core), NASAEndpoint (Data), APODDTO (Data)
// Returns: APOD (Domain) — the only Domain type it touches

final class APODRepository: APODRepositoryProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func fetchAPOD() async throws -> APOD {
        // 1. Tell NetworkClient which endpoint to hit
        // 2. Tell it to decode into APODDTO
        // 3. Convert DTO → Domain entity
        let dto: APODDTO = try await client.fetch(NASAEndpoint.apod)
        return dto.toDomain()
    }

    func fetchAPOD(date: String) async throws -> APOD {
        let dto: APODDTO = try await client.fetch(NASAEndpoint.apodByDate(date: date))
        return dto.toDomain()
    }
}
