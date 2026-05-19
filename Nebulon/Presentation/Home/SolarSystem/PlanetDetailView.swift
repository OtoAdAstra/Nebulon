import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    var onDismiss: () -> Void

    var body: some View {
        NavigationContainer(onDismiss: onDismiss) {
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
        }
    }
}
