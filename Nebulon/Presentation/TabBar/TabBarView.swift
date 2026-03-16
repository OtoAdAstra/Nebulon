import SwiftUI

struct TabBarView: View {
    var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                
                StarfieldBackground()
                    .ignoresSafeArea()
                
                Group {
                    switch coordinator.selectedTab {
                    case .home:
                        HomeView(coordinator: coordinator.homeCoordinator)
                    case .explore:
                        Text("Explore").foregroundStyle(.white)
                    case .mars:
                        Text("Mars").foregroundStyle(.white)
                    case .neo:
                        Text("NEOs").foregroundStyle(.white)
                    case .ar:
                        Text("AR").foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            if !coordinator.hideTabBar {
                TabBar(selectedTab: Bindable(coordinator).selectedTab)
                    .padding(.bottom, 0)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
