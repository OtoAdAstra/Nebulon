final class APODRepository: APODRepositoryProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func fetchAPOD() async throws -> APOD {
        print("📡 Repository: fetching today's APOD")
        let dto: APODDTO = try await client.fetch(NASAEndpoint.apod)
        print("📡 Repository: received DTO — \"\(dto.title)\" (\(dto.mediaType))")
        return dto.toDomain()
    }

    func fetchAPOD(date: String) async throws -> APOD {
        print("📡 Repository: fetching APOD for date \(date)")
        let dto: APODDTO = try await client.fetch(NASAEndpoint.apodByDate(date: date))
        print("📡 Repository: received DTO — \"\(dto.title)\" (\(dto.mediaType))")
        return dto.toDomain()
    }
}
