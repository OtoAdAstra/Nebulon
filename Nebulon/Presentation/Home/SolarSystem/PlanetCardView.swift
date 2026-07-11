import SwiftUI

struct PlanetCardView: View {
    let planet: Planet
    let onTap: () -> Void

    private var planetRadius: CGFloat {
        let minRadius: CGFloat = 22
        let maxRadius: CGFloat = 42
        return minRadius + (maxRadius - minRadius) * planet.size
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                ZStack {
                    PlanetSphere(planet: planet, radius: planetRadius)

                    if let ringColor = planet.ringColor {
                        PlanetRing(color: ringColor, radius: planetRadius)
                    }
                }
                .frame(width: Design.planetCardSize, height: Design.planetCardSize)

                VStack(spacing: 2) {
                    Text(planet.name)
                        .font(Design.cardTitleFont)
                        .foregroundStyle(.white)
                    Text(planet.subtitle)
                        .font(Design.cardCaptionFont)
                        .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
                }
                .padding(.bottom)
            }
            .frame(width: Design.planetCardSize)
            .materialCard(cornerRadius: Design.planetCardRadius)
        }
        .buttonStyle(.plain)
        
    }
}

// MARK: - 3D Planet Sphere

private struct PlanetSphere: View {
    let planet: Planet
    let radius: CGFloat

    var body: some View {
        Circle()
            .fill(planet.color)
            .saturation(1.4)
            .frame(width: radius * 2, height: radius * 2)
            .overlay {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [.white.opacity(0.5), .white.opacity(0.1), .clear],
                            center: UnitPoint(x: 0.3, y: 0.25),
                            startRadius: 0,
                            endRadius: radius * 0.9
                        )
                    )
            }
            .overlay {
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
                    colors: [color.opacity(0.6), color.opacity(0.2), color.opacity(0.5)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 3
            )
            .frame(width: radius * 3.2, height: radius * 0.9)
            .rotationEffect(.degrees(-20))
    }
}
