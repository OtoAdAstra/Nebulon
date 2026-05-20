import SwiftUI

struct TabBarView: View {
    var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {

            StarfieldBackground()
                .ignoresSafeArea()

            Group {
                switch coordinator.selectedTab {
                    case .home:
                        HomeView(coordinator: coordinator.homeCoordinator)

                    case .search:
                            SearchView(coordinator: coordinator.searchCoordinator)

                    case .view:
                        Text("Mars").foregroundStyle(.white)

                    case .ai:
                        Text("NEOs").foregroundStyle(.white)
                
                    case .profile:
                        Text("Profile")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if !coordinator.hideTabBar {
                TabBar(selectedTab: Bindable(coordinator).selectedTab)
                    .padding(.bottom, 0)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }


        }
    }
    
}
