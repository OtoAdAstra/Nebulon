protocol APODRepositoryProtocol {
    func fetchAPOD() async throws -> APOD
    func fetchAPOD(date: String) async throws -> APOD
}
