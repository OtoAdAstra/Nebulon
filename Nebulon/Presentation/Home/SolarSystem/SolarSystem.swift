import SwiftUI

struct SolarSystemView: View {
    let viewModel: SolarSystemViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Section header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Solar System")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    Text("Explore the planets")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.45))
                }
                Spacer()
            }
            .padding(.horizontal, 28)

            // Horizontal planet carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.planets) { planet in
                        PlanetCardView(planet: planet) {
                            viewModel.onPlanetTapped(planet)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

#Preview {
    SolarSystemView(viewModel: SolarSystemViewModel())
        .padding()
        .background(.black)
}
