import Foundation

struct SearchSpaceMediaUseCase: SearchSpaceMediaUseCaseProtocol {
    private let repository: MediaLibraryRepositoryProtocol

    init(repository: MediaLibraryRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String, page: Int) async throws -> SpaceMediaPage {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return SpaceMediaPage(items: [], totalHits: 0)
        }
        return try await repository.search(query: trimmed, page: max(1, page))
    }
}
