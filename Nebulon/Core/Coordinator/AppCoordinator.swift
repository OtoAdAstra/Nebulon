import Observation

@Observable
final class AppCoordinator {

    // owns tab state
    var selectedTab: Tabs = .home

    // owns ViewModels — created once, never recreated
    let apodViewModel: APODViewModel

    init(container: DIContainer) {
        apodViewModel = container.makeAPODViewModel()
    }
}
