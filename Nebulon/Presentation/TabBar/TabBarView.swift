import SwiftUI

struct TabBarView: View {
    var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {

            StarfieldBackground()
                .ignoresSafeArea()

            ZStack {
                tabPane(.home) {
                    HomeView(coordinator: coordinator.homeCoordinator)
                }
                tabPane(.search) {
                    SearchView(coordinator: coordinator.searchCoordinator)
                }
                tabPane(.view) {
                    Text("Mars").foregroundStyle(.white)
                }
                tabPane(.ai) {
                    Text("NEOs").foregroundStyle(.white)
                }
                tabPane(.profile) {
                    Text("Profile")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut(duration: 0.15), value: coordinator.selectedTab)

            if !coordinator.hideTabBar {
                TabBar(selectedTab: coordinator.selectedTab) { tab in
                    coordinator.select(tab)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: coordinator.selectedTab) {
            dismissKeyboard()
        }
    }

    private func tabPane<Content: View>(
        _ tab: Tabs,
        @ViewBuilder content: () -> Content
    ) -> some View {
        let isSelected = coordinator.selectedTab == tab
        return content()
            .opacity(isSelected ? 1 : 0)
            .allowsHitTesting(isSelected)
            .accessibilityHidden(!isSelected)
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
