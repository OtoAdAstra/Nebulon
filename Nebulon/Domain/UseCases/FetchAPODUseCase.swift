// Encapsulates ONE business operation
// Depends on protocol, not implementation
// No networking knowledge — just orchestration

struct FetchAPODUseCase {
    private let repository: APODRepositoryProtocol

    init(repository: APODRepositoryProtocol) {
        self.repository = repository
    }

    // Today's APOD
    func execute() async throws -> APOD {
        try await repository.fetchAPOD()
    }

    // Specific date
    func execute(date: String) async throws -> APOD {
        try await repository.fetchAPOD(date: date)
    }
}
