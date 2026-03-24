protocol FetchAPODUseCaseProtocol {
    func execute() async throws -> APOD
    func execute(date: String) async throws -> APOD
}

struct FetchAPODUseCase: FetchAPODUseCaseProtocol {
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
