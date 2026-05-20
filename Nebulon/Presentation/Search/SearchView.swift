import SwiftUI

struct SearchView: View {
    var coordinator: SearchCoordinator
    
    var body: some View {
        ZStack {
            switch coordinator.route {
                case .list:
                    SearchListView()
            }
        }
    }
}

private struct SearchListView: View {

    var body: some View {
        ScrollView {
            VStack {

            }
        }
    }
}
