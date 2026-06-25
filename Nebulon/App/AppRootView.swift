import SwiftUI

struct AppRootView: View {
    @State private var coordinator: AppCoordinator

    init(container: DIContainer) {
        _coordinator = State(
            wrappedValue: AppCoordinator(container: container)
        )
    }

    var body: some View {
        TabBarView(coordinator: coordinator)
    }
}
