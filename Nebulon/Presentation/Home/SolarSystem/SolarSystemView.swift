import SwiftUI

struct SolarSystemView: View {
    let viewModel: SolarSystemViewModel
    var onPlanetTapped: (Planet) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Solar System")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Design.itemSpacing) {
                    ForEach(viewModel.planets) { planet in
                        PlanetCardView(planet: planet) {
                            onPlanetTapped(planet)
                        }
                    }
                }
            }
            .contentMargins(.horizontal, Design.contentPadding)
            .padding(.horizontal, -Design.contentPadding)
        }
    }
}
