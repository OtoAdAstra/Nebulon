//
//  DIContainer.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 02.03.26.
//

final class DIContainer {

    // MARK: - Network
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()

    // MARK: - Repositories
    private lazy var apodRepository: APODRepositoryProtocol = APODRepository(
        client: networkClient
    )
    
    // MARK: - UseCase
    private lazy var fetchAPODUseCase: FetchAPODUseCaseProtocol = FetchAPODUseCase(repository: apodRepository)

    // MARK: - ViewModels
    func makeAPODViewModel() -> APODViewModel {
        APODViewModel(fetchAPODUseCase: fetchAPODUseCase)
    }
}
