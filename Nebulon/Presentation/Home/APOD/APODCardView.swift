import SwiftUI

struct APODCardView: View {
    let viewModel: APODViewModel

    var body: some View {
        GeometryReader { geo in

            // MARK: - Card View
            ZStack(alignment: .bottomLeading) {

                // Media — fill the card, clipped to bounds
                MediaView(url: viewModel.apod?.url ?? "", isVideo: viewModel.apod?.isVideo ?? false)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()

                // Gradient
                LinearGradient(
                    colors: [.clear, .clear, .black.opacity(0.9)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Text content
                VStack(alignment: .leading, spacing: 8) {

                    // Pill
                    Text("Astronomy Picture of the Day")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("LightSpace"), in: Capsule())

                    // Title
                    Text(viewModel.apod?.title ?? "")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    // Explanation
                    Text(viewModel.apod?.explanation ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                        .lineLimit(2)

                    // Date
                    Text(viewModel.apod?.date ?? "")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 16)
            }
            .shadow(color: .black.opacity(0.4), radius: 0.5, x: 0, y: 0)
        }
        
    }
}

#Preview {
    APODCardView(
        viewModel: APODViewModel(
            fetchAPODUseCase: FetchAPODUseCase(
                repository: APODRepository(client: NetworkClient())
            )
        )
    )
}
