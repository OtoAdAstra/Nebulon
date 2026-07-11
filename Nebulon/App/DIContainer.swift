final class DIContainer {

    // MARK: - Network
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()

    // MARK: - Repositories
    private lazy var apodRepository: APODRepositoryProtocol = APODRepository(
        client: networkClient
    )

    private lazy var mediaLibraryRepository: MediaLibraryRepositoryProtocol = MediaLibraryRepository(
        client: networkClient
    )

    // MARK: - UseCase
    private lazy var fetchAPODUseCase: FetchAPODUseCaseProtocol = FetchAPODUseCase(repository: apodRepository)

    private lazy var searchSpaceMediaUseCase: SearchSpaceMediaUseCaseProtocol = SearchSpaceMediaUseCase(repository: mediaLibraryRepository)

    // MARK: - ViewModels
    func makeAPODViewModel() -> APODViewModel {
        APODViewModel(fetchAPODUseCase: fetchAPODUseCase)
    }

    func makeSolarSystemViewModel() -> SolarSystemViewModel {
        SolarSystemViewModel()
    }

    @MainActor
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(searchUseCase: searchSpaceMediaUseCase)
    }
}
