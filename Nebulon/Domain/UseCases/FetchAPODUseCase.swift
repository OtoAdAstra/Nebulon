struct FetchAPODUseCase: FetchAPODUseCaseProtocol {
    private let repository: APODRepositoryProtocol

    init(repository: APODRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> APOD {
        try await repository.fetchAPOD()
    }

    func execute(date: String) async throws -> APOD {
        try await repository.fetchAPOD(date: date)
    }
}
