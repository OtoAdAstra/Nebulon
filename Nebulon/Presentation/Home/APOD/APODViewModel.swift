// Presentation/APOD/APODViewModel.swift

// Knows about: UseCase (Domain), APOD entity (Domain)
// Knows nothing about: networking, JSON, URLSession
// Owns UI state — loading, loaded, error

import Foundation

@MainActor
@Observable
final class APODViewModel {

    private(set) var apod: APOD?
    private(set) var state: ViewState = .idle

    private let fetchAPODUseCase: FetchAPODUseCase

    init(fetchAPODUseCase: FetchAPODUseCase) {
        self.fetchAPODUseCase = fetchAPODUseCase
    }

    func onAppear() async {
        guard apod == nil else { return }
        await loadTodaysAPOD()
    }

    func loadAPOD(for date: String) async {
        await load { [self] in
            try await fetchAPODUseCase.execute(date: date)
        }
    }

    private func loadTodaysAPOD() async {
        await load { [self] in
            try await fetchAPODUseCase.execute()
        }
    }

    // DRY helper — handles state transitions for any load operation
    private func load(_ operation: () async throws -> APOD) async {
        state = .loading
        do {
            apod = try await operation()
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

//MARK: - States
enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
}
