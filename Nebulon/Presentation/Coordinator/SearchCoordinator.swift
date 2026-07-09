import Observation
import SwiftUI

@Observable
final class SearchCoordinator {

    // MARK: - Routes

    enum Route: Equatable {
        case list
        case detail(SpaceMedia)
    }

    var route: Route = .list

    var hideTabBar: Bool {
        route != .list
    }

    // MARK: - ViewModels

    let searchViewModel: SearchViewModel

    // MARK: - Init

    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }

    // MARK: - Navigation Actions

    func showDetail(_ media: SpaceMedia) {
        route = .detail(media)
    }

    func dismissDetail() {
        route = .list
    }
}
