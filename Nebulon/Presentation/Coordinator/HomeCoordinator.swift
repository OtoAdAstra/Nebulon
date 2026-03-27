import Observation
import SwiftUI

@Observable
final class HomeCoordinator {

    // MARK: - Routes

    enum Route: Equatable {
        case list
        case apodDetail
        case planetDetail(Planet)
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

    func showPlanetDetail(_ planet: Planet) {
        route = .planetDetail(planet)
    }

    func dismissPlanetDetail() {
        route = .list
    }
}
