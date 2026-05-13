import SwiftUI

struct APODView: View {
    let viewModel: APODViewModel
    var heroNamespace: Namespace.ID
    var onDismiss: () -> Void

    @State private var isImageFullScreen = false
    @State private var isExpanded = false

    private let imageHeight: CGFloat = UIScreen.main.bounds.height * Design.heroImageRatio

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Color.clear
                        .frame(height: imageHeight)
                        .overlay {
                            MediaView(
                                url: viewModel.apod?.url ?? "",
                                isVideo: viewModel.apod?.isVideo ?? false
                            )
                        }
                        .clipped()
                        .mask(
                            VStack(spacing: 0) {
                                Color.white
                                LinearGradient(
                                    colors: [.white, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: imageHeight * 0.1)
                            }
                        )
                        .onTapGesture {
                            guard viewModel.apod?.isVideo != true else { return }
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isImageFullScreen = true
                            }
                        }

                    Text(viewModel.apod?.title ?? "")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, Design.contentPadding)
                        .padding(.bottom, Design.contentPadding)
                }
                .clipShape(.rect(topLeadingRadius: Design.sectionPadding, topTrailingRadius: Design.sectionPadding))
                .matchedGeometryEffect(id: "apod_hero", in: heroNamespace)

                // Action Buttons
                HStack(spacing: Design.itemSpacing) {
                    ActionButton(icon: "document.on.document", label: "Copy") {}
                    ActionButton(icon: "square.and.arrow.up", label: "Share") {}
                    ActionButton(icon: "arrow.down.to.line", label: "Wallpaper") {}
                }
                .padding(.horizontal, Design.contentPadding)
                .padding(.vertical, Design.cardRadius)

                // Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text(viewModel.apod?.explanation ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                        .lineSpacing(5)
                        .lineLimit(isExpanded ? nil : 4)

                    Button(isExpanded ? "Show less" : "Read more") {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isExpanded.toggle()
                        }
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color(red: 0.3, green: 0.6, blue: 1.0))
                }
                .padding(Design.cardRadius)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardBackground()
                .padding(.horizontal, Design.contentPadding)

                // Details
                VStack(alignment: .leading, spacing: 0) {
                    Text("Details")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 14)

                    DetailRow(icon: "calendar", iconColor: .blue, label: "Date", value: viewModel.apod?.date ?? "")
                    DetailRow(icon: "camera", iconColor: .purple, label: "Media Type", value: viewModel.apod?.mediaType.capitalized ?? "")

                    if let copyright = viewModel.apod?.copyright {
                        DetailRow(icon: "c.circle", iconColor: .brown, label: "Copyright", value: copyright)
                    }
                }
                .padding(Design.cardRadius)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardBackground()
                .padding(.horizontal, Design.contentPadding)
                .padding(.vertical, Design.cardRadius)
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topTrailing) {
            DismissButton { onDismiss() }
                .padding(.leading, Design.cardRadius)
                .padding(.top, 8)
        }
        .fullScreenCover(isPresented: $isImageFullScreen) {
            FullScreenAPODImageView(url: viewModel.apod?.url ?? "")
        }
    }
}

#Preview {
    @Previewable @Namespace var ns
    APODView(
        viewModel: APODViewModel(
            fetchAPODUseCase: FetchAPODUseCase(
                repository: APODRepository(client: NetworkClient())
            )
        ),
        heroNamespace: ns,
        onDismiss: {}
    )
}
