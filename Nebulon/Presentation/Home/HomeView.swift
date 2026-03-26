// Presentation/Home/ContentView.swift

import SkeletonUI
import SwiftUI

struct HomeView: View {
    var coordinator: HomeCoordinator
    @Namespace private var heroNamespace

    var body: some View {

        ZStack {
            // MARK: - HomeView
            if coordinator.route == .list {
                ScrollView {
                    VStack(spacing: 60) {
                        APODCardView(
                            viewModel: coordinator.apodViewModel
                        )
                        .skeleton(
                            with: !coordinator.apodViewModel.isFullyLoaded,
                            animation: .pulse(),
                            appearance: .solid(
                                color: .white.opacity(0.08),
                                background: .white.opacity(0.03)
                            ),
                            shape: .rounded(.radius(34, style: .continuous))
                        )
                        .aspectRatio(0.95, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 34))
                        .padding(.horizontal)
                        .matchedGeometryEffect(id: "apod_hero", in: heroNamespace)
                        .onTapGesture {
                            guard coordinator.apodViewModel.isFullyLoaded else {
                                return
                            }
                            withAnimation(
                                .spring(response: 0.5, dampingFraction: 0.85)
                            ) {
                                coordinator.showAPODDetail()
                            }
                        }

                        // MARK: - Solar System
                        SolarSystemView(viewModel: coordinator.solarSystemViewModel)

                        Spacer()
                    }
                    .padding(.vertical)
                    .padding(.bottom, 56)
                }
                .safeAreaInset(edge: .top) {
                    AppNameView()
                        .frame(maxWidth: .infinity, alignment: .center)
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

#Preview {
    let container = DIContainer()
    let coordinator = AppCoordinator(container: container)
    HomeView(coordinator: coordinator.homeCoordinator)
}
