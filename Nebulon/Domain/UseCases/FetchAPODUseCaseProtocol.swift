protocol FetchAPODUseCaseProtocol {
    func execute() async throws -> APOD
    func execute(date: String) async throws -> APOD
}
