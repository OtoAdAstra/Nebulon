// Domain/UseCases/SearchSpaceMediaUseCase.swift

import Foundation

protocol SearchSpaceMediaUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> SpaceMediaPage
}

struct SearchSpaceMediaUseCase: SearchSpaceMediaUseCaseProtocol {
    private let repository: MediaLibraryRepositoryProtocol

    init(repository: MediaLibraryRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String, page: Int) async throws -> SpaceMediaPage {
        // Business rule: normalize the query before it hits the network.
        // An effectively-empty query returns an empty page — no wasted request.
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return SpaceMediaPage(items: [], totalHits: 0)
        }
        return try await repository.search(query: trimmed, page: max(1, page))
    }
}
