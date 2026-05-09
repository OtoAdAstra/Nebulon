import SafariServices
import SwiftUI

struct NewsView: View {
    @State private var showSafari = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("News")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    Text("Read latest astronomy news")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.45))
                }
                Spacer()
            }
            .padding(.horizontal, 28)

            Button {
                showSafari = true
            } label: {
                HStack {
                    Image(systemName: "newspaper.fill")
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.8))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Astronomy News")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                        Text("Latest from NASA")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.45))
                    }

                    Spacer()

                    Image(systemName: "arrow.up.right")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white.opacity(0.4))
                }
                .padding(18)
                .background(.white.opacity(0.06))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url: URL(string: "https://www.nasa.gov/news/")!)
                .ignoresSafeArea()
        }
    }
}

private struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredBarTintColor = .black
        vc.preferredControlTintColor = .white
        return vc
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
