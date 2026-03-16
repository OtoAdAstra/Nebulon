import Observation

@Observable
final class AppCoordinator {

    // MARK: - Tab State

    var selectedTab: Tabs = .home

    /// Derived — delegates to the active child coordinator
    var hideTabBar: Bool {
        switch selectedTab {
        case .home: return homeCoordinator.hideTabBar
        default: return false
        }
    }

    // MARK: - Child Coordinators

    let homeCoordinator: HomeCoordinator

    // MARK: - Init

    init(container: DIContainer) {
        let apodViewModel = container.makeAPODViewModel()
        homeCoordinator = HomeCoordinator(apodViewModel: apodViewModel)
    }
}
