import SwiftUI

struct SolarSystemView: View {
    let viewModel: SolarSystemViewModel
    var onPlanetTapped: (Planet) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Solar System")
                        .header()
                }
                Spacer()
            }
            .padding(.horizontal, 28)

            // Horizontal planet carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.planets) { planet in
                        PlanetCardView(planet: planet) {
                            onPlanetTapped(planet)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

#Preview {
    SolarSystemView(viewModel: SolarSystemViewModel(), onPlanetTapped: { _ in })
        .padding()
        .background(.black)
}
