import SwiftUI

// MARK: - Interactive Sheet Wrapper

struct PlanetDetailSheet: View {
    let planet: Planet
    let onDismiss: () -> Void

    @State private var dragOffset: CGFloat = 0

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width

        GeometryReader { geo in
            ZStack(alignment: .leading) {
                PlanetDetailView(planet: planet, onDismiss: onDismiss)
                    .offset(x: dragOffset)

                Color.clear
                    .frame(width: 30)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onChanged { value in
                                if value.translation.width > 0 {
                                    dragOffset = value.translation.width
                                }
                            }
                            .onEnded { value in
                                if value.translation.width > 100 || value.velocity.width > 500 {
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        dragOffset = screenWidth
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        onDismiss()
                                    }
                                } else {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
            }
        }
    }
}

// MARK: - Planet Detail View

struct PlanetDetailView: View {
    let planet: Planet
    var onDismiss: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                Planet3DView(planet: planet)
                    .frame(maxWidth: .infinity)
                    .frame(height: Design.planet3DHeight)
                    .padding(.top, 24)

                VStack(spacing: 4) {
                    Text(planet.name)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text(planet.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(Design.tertiaryTextOpacity))
                }

                Text(planet.description)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 24)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Design.cardRadius) {
                    StatCard(title: "Diameter", value: "\(planet.diameter) km")
                    StatCard(title: "Distance from Sun", value: "\(planet.distanceFromSun)M km")
                    StatCard(title: "Day Length", value: planet.dayLength)
                    StatCard(title: "Year Length", value: planet.yearLength)
                    StatCard(title: "Moons", value: "\(planet.moons)")
                    StatCard(title: "Temperature", value: planet.temperature)
                }
                .padding(.horizontal, 24)

                Spacer(minLength: 40)
            }
        }
        .overlay(alignment: .topLeading) {
            DismissButton("chevron.left") { onDismiss() }
        }
    }
}
