import SkeletonUI
import SwiftUI

struct HomeView: View {
    var coordinator: HomeCoordinator
    @Namespace private var heroNamespace

    var body: some View {
        ZStack {
            switch coordinator.route {
            case .list:
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 60) {
                        APODCardView(viewModel: coordinator.apodViewModel)
                            .skeleton(
                                with: !coordinator.apodViewModel.isFullyLoaded,
                                animation: .pulse(),
                                appearance: .solid(
                                    color: .white.opacity(0.08),
                                    background: .white.opacity(0.03)
                                ),
                                shape: .rounded(.radius(Design.heroRadius, style: .continuous))
                            )
                            .aspectRatio(Design.apodAspectRatio, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: Design.heroRadius))
                            .matchedGeometryEffect(id: "apod_hero", in: heroNamespace)
                            .onTapGesture {
                                guard coordinator.apodViewModel.isFullyLoaded else { return }
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                                    coordinator.showAPODDetail()
                                }
                            }

                        SolarSystemView(viewModel: coordinator.solarSystemViewModel) { planet in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                coordinator.showPlanetDetail(planet)
                            }
                        }

                        NewsView()

                        Spacer()
                    }
                    .padding(.vertical, 6)
                    .padding(.bottom, 56)
                    .padding(.horizontal, Design.contentPadding)
                }
                .safeAreaInset(edge: .top) {
                    AppNameView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                .task {
                    await coordinator.apodViewModel.onAppear()
                }

            case .apodDetail:
                APODView(
                    viewModel: coordinator.apodViewModel,
                    heroNamespace: heroNamespace,
                    onDismiss: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                            coordinator.dismissAPODDetail()
                        }
                    }
                )

            case .planetDetail(let planet):
                PlanetDetailView(planet: planet) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        coordinator.dismissPlanetDetail()
                    }
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}
