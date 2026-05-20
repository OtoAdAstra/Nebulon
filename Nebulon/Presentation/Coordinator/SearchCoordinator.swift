import Observation
import SwiftUI

@Observable
final class SearchCoordinator {
    
    // MARK: - Routes
    enum Route: Equatable {
        case list
    }
    
    var route: Route = .list
    
    var hideTabBar: Bool {
        route != .list
    }
    
    // MARK: - ViewModels
    
    // MARK: - Init
    
    // MARK: - Navigation Actions
    
}
