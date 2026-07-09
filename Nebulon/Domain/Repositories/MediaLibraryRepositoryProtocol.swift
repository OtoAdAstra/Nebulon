protocol MediaLibraryRepositoryProtocol {
    func search(query: String, page: Int) async throws -> SpaceMediaPage
}
