protocol SearchSpaceMediaUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> SpaceMediaPage
}
