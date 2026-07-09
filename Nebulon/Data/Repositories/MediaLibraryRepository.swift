// Knows about: NetworkClient (Core), NASAImageLibraryEndpoint (Data), NASAImageSearchDTO (Data)
// Returns: SpaceMediaPage (Domain)

final class MediaLibraryRepository: MediaLibraryRepositoryProtocol {
    private let client: NetworkClientProtocol
    private let pageSize: Int

    init(client: NetworkClientProtocol, pageSize: Int = 24) {
        self.client = client
        self.pageSize = pageSize
    }

    func search(query: String, page: Int) async throws -> SpaceMediaPage {
        let dto: NASAImageSearchDTO = try await client.fetch(
            NASAImageLibraryEndpoint.search(query: query, page: page, pageSize: pageSize)
        )
        return dto.toDomain()
    }
}
