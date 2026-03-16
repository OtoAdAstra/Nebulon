// Presentation/Home/ContentView.swift

import SwiftUI

struct HomeView: View {
    var coordinator: HomeCoordinator
    @Namespace private var heroNamespace

    var body: some View {

        ZStack {
            // MARK: - HomeView
            if coordinator.route == .list {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        AppNameView()
                        
                        APODCardView(
                            viewModel: coordinator.apodViewModel,
                            heroNamespace: heroNamespace
                        )
                        .onTapGesture {
                            withAnimation(
                                .spring(response: 0.5, dampingFraction: 0.85)
                            ) {
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
                // MARK: - APOD View

                    APODView(
                        viewModel: coordinator.apodViewModel,
                        heroNamespace: heroNamespace,
                        onDismiss: {
                            withAnimation(
                                .spring(response: 0.5, dampingFraction: 0.85)
                            ) {
                                coordinator.dismissAPODDetail()
                            }
                        }
                    )
                
            }
        }

    }
}

struct AppNameView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("Nebulon")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(6)
                .background(
                    Circle()
                        .fill(.blue.opacity(0.15))
                )
                .overlay(
                    Circle()
                        .stroke(.blue.opacity(0.6), lineWidth: 1.5)
                )

            VStack(alignment: .leading, spacing: 1) {
                Text("Nebulon")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Text("EXPLORER")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.blue.opacity(0.7))
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    let coordinator = AppCoordinator(container: container)
    HomeView(coordinator: coordinator.homeCoordinator)
}
