import SwiftUI

struct TabBarView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                
                StarfieldBackground()
                    .ignoresSafeArea()
                
                Group {
                    switch coordinator.selectedTab {
                    case .home:
                        HomeView(viewModel: coordinator.apodViewModel)
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

            TabBar(selectedTab: $coordinator.selectedTab)
                .padding(.bottom, 0)
        }
    }
}
