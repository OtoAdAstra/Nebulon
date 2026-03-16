// Presentation/Home/ContentView.swift

import SwiftUI

struct HomeView: View {
    var coordinator: HomeCoordinator
    @Namespace private var heroNamespace

    var body: some View {
        ZStack {
            if coordinator.route == .list {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        APODCardView(viewModel: coordinator.apodViewModel, heroNamespace: heroNamespace)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                                    coordinator.showAPODDetail()
                                }
                            }

                        Spacer()
                    }
                    .padding()
                }
                .task {
                    await coordinator.apodViewModel.onAppear()
                }
            } else {
                APODView(
                    viewModel: coordinator.apodViewModel,
                    heroNamespace: heroNamespace,
                    onDismiss: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                            coordinator.dismissAPODDetail()
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    let coordinator = AppCoordinator(container: container)
    HomeView(coordinator: coordinator.homeCoordinator)
}
