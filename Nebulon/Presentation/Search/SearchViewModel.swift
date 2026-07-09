import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {

    // MARK: - Output

    private(set) var results: [SpaceMedia] = []
    private(set) var state: ViewState = .idle
    private(set) var totalHits: Int = 0
    private(set) var isLoadingMore = false

    /// Curated starting points shown before the user types anything
    let suggestions = [
        "Nebula", "Black Hole", "Apollo 11", "Mars Rover",
        "Saturn", "Galaxy", "Supernova", "Earth at Night",
    ]

    // MARK: - Input

    var query: String = "" {
        didSet {
            guard query != oldValue else { return }
            queryChanged()
        }
    }

    // MARK: - Dependencies

    private let searchUseCase: SearchSpaceMediaUseCaseProtocol

    // MARK: - Internal State

    private var searchTask: Task<Void, Never>?
    private var currentPage = 1
    private var loadedIDs = Set<String>() // the API can repeat items across pages

    private var canLoadMore: Bool {
        results.count < totalHits
    }

    private static let debounceDelay: Duration = .milliseconds(350)

    // MARK: - Init

    init(searchUseCase: SearchSpaceMediaUseCaseProtocol) {
        self.searchUseCase = searchUseCase
    }

    // MARK: - Actions

    func selectSuggestion(_ suggestion: String) {
        query = suggestion
    }

    func retry() {
        startSearch(debounced: false)
    }

    /// Called from each grid cell — fetches the next page when the user nears the end
    func loadMoreIfNeeded(current media: SpaceMedia) {
        guard canLoadMore, !isLoadingMore, state == .loaded else { return }
        // Trigger when the visible item is within the last row or two
        guard let index = results.firstIndex(of: media),
              index >= results.count - 4 else { return }
        loadNextPage()
    }

    // MARK: - Search Pipeline

    private func queryChanged() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            searchTask?.cancel()
            clearResults(state: .idle)
            return
        }
        startSearch(debounced: true)
    }

    /// Debounce via task cancellation: every keystroke cancels the previous
    /// in-flight task, so only the last query within the window hits the network.
    private func startSearch(debounced: Bool) {
        searchTask?.cancel()
        let queryToRun = query

        searchTask = Task { [weak self] in
            if debounced {
                try? await Task.sleep(for: Self.debounceDelay)
            }
            guard !Task.isCancelled else { return }
            await self?.performSearch(queryToRun)
        }
    }

    private func performSearch(_ query: String) async {
        clearResults(state: .loading)

        do {
            let page = try await searchUseCase.execute(query: query, page: 1)
            guard !Task.isCancelled else { return }

            append(page.items)
            totalHits = page.totalHits
            state = .loaded
        } catch is CancellationError {
            // A newer query took over — nothing to do
        } catch {
            guard !Task.isCancelled else { return }
            state = .error(error.localizedDescription)
        }
    }

    private func loadNextPage() {
        isLoadingMore = true
        let queryToRun = query
        let nextPage = currentPage + 1

        Task { [weak self] in
            guard let self else { return }
            do {
                let page = try await searchUseCase.execute(query: queryToRun, page: nextPage)
                // Discard if the query changed while this page was in flight
                guard queryToRun == self.query, self.state == .loaded else { return }

                self.append(page.items)
                self.currentPage = nextPage
                self.totalHits = page.totalHits
            } catch {
                // Pagination failures are non-fatal — the user can scroll again to retry
            }
            self.isLoadingMore = false
        }
    }

    // MARK: - Helpers

    private func append(_ items: [SpaceMedia]) {
        let fresh = items.filter { loadedIDs.insert($0.id).inserted }
        results.append(contentsOf: fresh)
    }

    private func clearResults(state: ViewState) {
        results = []
        loadedIDs = []
        totalHits = 0
        currentPage = 1
        isLoadingMore = false
        self.state = state
    }
}
