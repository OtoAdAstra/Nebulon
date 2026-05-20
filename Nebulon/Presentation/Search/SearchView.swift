import SwiftUI

struct SearchView: View {
    var coordinator: SearchCoordinator
    
    var body: some View {
        ZStack {
            switch coordinator.route {
                case .list:
                    ScrollView {
                        VStack {
                            Text("123")
                        }
                    }
            }
        }
    }
}
