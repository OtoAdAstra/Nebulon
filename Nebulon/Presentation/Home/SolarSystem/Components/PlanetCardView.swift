import SwiftUI

struct PlanetCardView: View {
    let planet: Planet
    let onTap: () -> Void

    private let cardSize: CGFloat = 120

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                ZStack {
                    // Ambient glow behind the planet
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    planet.color.opacity(0.4),
                                    planet.color.opacity(0.1),
                                    .clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: planetRadius * 1.5
                            )
                        )
                        .frame(width: planetRadius * 3, height: planetRadius * 3)

                    // Planet sphere
                    PlanetSphere(planet: planet, radius: planetRadius)

                    // Ring overlay (Saturn, Uranus)
                    if let ringColor = planet.ringColor {
                        PlanetRing(color: ringColor, radius: planetRadius)
                    }
                }
                .frame(width: cardSize, height: cardSize)

                // Label
                VStack(spacing: 2) {
                    Text(planet.name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(planet.subtitle)
                        .font(.system(size: 10))
                        .foregroundStyle(.white.opacity(0.45))
                }
            }
            .frame(width: cardSize)
        }
        .buttonStyle(.plain)
    }

    private var planetRadius: CGFloat {
        let minRadius: CGFloat = 16
        let maxRadius: CGFloat = 36
        return minRadius + (maxRadius - minRadius) * planet.size
    }
}

// MARK: - 3D Planet Sphere

private struct PlanetSphere: View {
    let planet: Planet
    let radius: CGFloat

    var body: some View {
        Circle()
            .fill(planet.color)
            .frame(width: radius * 2, height: radius * 2)
            .overlay {
                // Specular highlight — top-left light source
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                .white.opacity(0.5),
                                .white.opacity(0.1),
                                .clear
                            ],
                            center: UnitPoint(x: 0.3, y: 0.25),
                            startRadius: 0,
                            endRadius: radius * 0.9
                        )
                    )
            }
            .overlay {
                // Shadow terminator — dark side
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.5)],
                            startPoint: UnitPoint(x: 0.3, y: 0.0),
                            endPoint: UnitPoint(x: 1.0, y: 1.0)
                        )
                    )
            }
            .overlay {
                // Atmospheric rim light
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            colors: [
                                planet.color.opacity(0.6),
                                .white.opacity(0.3),
                                planet.color.opacity(0.1),
                                .clear,
                                planet.color.opacity(0.6),
                            ],
                            center: .center,
                            startAngle: .degrees(180),
                            endAngle: .degrees(540)
                        ),
                        lineWidth: 1.5
                    )
            }
            .shadow(color: planet.color.opacity(0.6), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Planet Ring

private struct PlanetRing: View {
    let color: Color
    let radius: CGFloat

    var body: some View {
        Ellipse()
            .strokeBorder(
                LinearGradient(
                    colors: [
                        color.opacity(0.6),
                        color.opacity(0.2),
                        color.opacity(0.5),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 3
            )
            .frame(width: radius * 3.2, height: radius * 0.9)
            .rotationEffect(.degrees(-20))
    }
}

#Preview {
    HStack(spacing: 16) {
        PlanetCardView(planet: Planet.allPlanets[2], onTap: {})
        PlanetCardView(planet: Planet.allPlanets[5], onTap: {})
        PlanetCardView(planet: Planet.allPlanets[7], onTap: {})
    }
    .padding()
    .background(.black)
}
