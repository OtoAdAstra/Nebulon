import Observation

@Observable
final class AppCoordinator {

    // MARK: - Tab State

    var selectedTab: Tabs = .home

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
            searchViewModel: container.makeSearchViewModel()
        )
    }

    // MARK: - Tab Selection

    func select(_ tab: Tabs) {
        guard tab == selectedTab else {
            selectedTab = tab
            return
        }

        switch tab {
            case .home: homeCoordinator.scrollToTop()
            case .search: searchCoordinator.resetToDiscover()
            default: break
        }
    }
}
