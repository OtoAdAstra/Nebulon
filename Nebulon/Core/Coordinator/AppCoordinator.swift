import Observation

@Observable
final class AppCoordinator {

    // MARK: - Tab State

    var selectedTab: Tabs = .home

    /// Derived — delegates to the active child coordinator
    var hideTabBar: Bool {
        switch selectedTab {
            case .home: return homeCoordinator.hideTabBar
            case .search: return searchCoordinator.hideTabBar
        default: return false
        }
    }

    // MARK: - Child Coordinators

    let homeCoordinator: HomeCoordinator
    let searchCoordinator: SearchCoordinator

    // MARK: - Init

    init(container: DIContainer) {
        homeCoordinator = HomeCoordinator(
            apodViewModel: container.makeAPODViewModel(),
            solarSystemViewModel: container.makeSolarSystemViewModel()
        )
        searchCoordinator = SearchCoordinator(
            
        )
    }
}
