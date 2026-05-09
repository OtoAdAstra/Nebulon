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

                // Planet 3D model
                Planet3DView(planet: planet)
                    .frame(maxWidth: .infinity)
                    .frame(height: 380)
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
