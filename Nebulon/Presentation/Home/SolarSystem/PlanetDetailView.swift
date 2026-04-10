import SwiftUI

// MARK: - Interactive Sheet Wrapper

struct PlanetDetailSheet: View {
    let planet: Planet
    let onDismiss: () -> Void

    @State private var dragOffset: CGFloat = 0

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let progress = min(max(dragOffset / screenWidth, 0), 1.0)

        GeometryReader { geo in
            ZStack(alignment: .leading) {

                PlanetDetailView(planet: planet, onDismiss: onDismiss)
                    .offset(x: dragOffset)

                // Invisible edge drag handle on the left
                Color.clear
                    .frame(width: 30)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onChanged { value in
                                let translation = value.translation.width
                                if translation > 0 {
                                    dragOffset = translation
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
    var onDismiss: (() -> Void)? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                // Back button
                if let onDismiss {
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                onDismiss()
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .fontWeight(.semibold)
                                Text("Back")
                            }
                            .foregroundStyle(.white.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                }

                // Planet visual
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    planet.color.opacity(0.5),
                                    planet.color.opacity(0.15),
                                    .clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 140
                            )
                        )
                        .frame(width: 280, height: 280)

                    PlanetVisual(planet: planet)
                }
                .padding(.top, onDismiss == nil ? 24 : 0)

                // Name and subtitle
                VStack(spacing: 4) {
                    Text(planet.name)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text(planet.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.5))
                }

                // Description
                Text(planet.description)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 24)

                // Stats grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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

// MARK: - Planet Visual

private struct PlanetVisual: View {
    let planet: Planet
    private let radius: CGFloat = 80

    var body: some View {
        ZStack {
            // Planet sphere
            Circle()
                .fill(planet.color)
                .frame(width: radius * 2, height: radius * 2)
                .overlay {
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
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.5)],
                                startPoint: UnitPoint(x: 0.3, y: 0.0),
                                endPoint: UnitPoint(x: 1.0, y: 1.0)
                            )
                        )
                }
                .shadow(color: planet.color.opacity(0.6), radius: 16, x: 0, y: 4)

            // Ring
            if let ringColor = planet.ringColor {
                Ellipse()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                ringColor.opacity(0.6),
                                ringColor.opacity(0.2),
                                ringColor.opacity(0.5),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: radius * 3.2, height: radius * 0.9)
                    .rotationEffect(.degrees(-20))
            }
        }
    }
}

// MARK: - Stat Card

private struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.45))
            Text(value)
                .font(.system(.body, design: .rounded, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlanetDetailView(planet: Planet.allPlanets[4], onDismiss: {})
    }
}
