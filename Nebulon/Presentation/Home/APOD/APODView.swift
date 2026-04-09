import SwiftUI

struct APODView: View {
    let viewModel: APODViewModel
    var heroNamespace: Namespace.ID
    var onDismiss: () -> Void

    @State private var isImageFullScreen = false
    @State private var isExpanded = false

    private let imageHeight: CGFloat = UIScreen.main.bounds.height * 0.6

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {

                // MARK: - Hero Image
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
                            guard viewModel.apod?.isVideo != true else {
                                return
                            }
                            withAnimation(
                                .spring(response: 0.35, dampingFraction: 0.85)
                            ) {
                                isImageFullScreen = true
                            }
                        }

                    // Title over image
                    Text(viewModel.apod?.title ?? "")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
                .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                .matchedGeometryEffect(id: "apod_hero", in: heroNamespace)

                // MARK: - Action Buttons
                HStack(spacing: 12) {
                    ActionButton(icon: "document.on.document", label: "Copy") {
                        // save action
                    }
                    ActionButton(icon: "square.and.arrow.up", label: "Share") {
                    }
                    ActionButton(icon: "arrow.down.to.line", label: "Wallpaper")
                    {
                        // wallpaper action
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)

                // MARK: - Description Card
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
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)

                // MARK: - Details Card
                VStack(alignment: .leading, spacing: 0) {
                    Text("Details")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 14)

                    DetailRow(
                        icon: "calendar",
                        iconColor: Color.blue,
                        label: "Date",
                        value: viewModel.apod?.date ?? ""
                    )

                    DetailRow(
                        icon: "camera",
                        iconColor: Color.purple,
                        label: "Media Type",
                        value: viewModel.apod?.mediaType.capitalized ?? ""
                    )

                    if let copyright = viewModel.apod?.copyright {
                        DetailRow(
                            icon: "c.circle",
                            iconColor: Color.brown,
                            label: "Copyright",
                            value: copyright
                        )
                    }

                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topTrailing) {
            Button {
                onDismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
                    .background(.ultraThinMaterial, in: Circle())
                    .padding()
            }
            .padding(.leading, 16)
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
