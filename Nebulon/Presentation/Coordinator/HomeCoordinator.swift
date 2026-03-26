import Observation

@Observable
final class HomeCoordinator {

    // MARK: - Routes

    enum Route: Equatable {
        case list
        case apodDetail
    }

    var route: Route = .list

    var hideTabBar: Bool {
        route != .list
    }

    // MARK: - ViewModels

    let apodViewModel: APODViewModel
    let solarSystemViewModel: SolarSystemViewModel

    // MARK: - Init

    init(apodViewModel: APODViewModel, solarSystemViewModel: SolarSystemViewModel) {
        self.apodViewModel = apodViewModel
        self.solarSystemViewModel = solarSystemViewModel
    }

    // MARK: - Navigation Actions

    func showAPODDetail() {
        route = .apodDetail
    }

    func dismissAPODDetail() {
        route = .list
    }
}
