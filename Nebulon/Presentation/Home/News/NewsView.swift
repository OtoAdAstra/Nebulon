import SafariServices
import SwiftUI

struct NewsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("News")
                        .header()
                }
                Spacer()
            }
            .padding(.horizontal, 28)

            VStack(spacing: 0) {
                NewsRow(
                    icon: "newspaper.fill",
                    title: "Webb Spots Exoplanet Clouds",
                    subtitle: "New findings from JWST",
                    url: "https://www.nasa.gov/news/"
                )

                Divider()
                    .overlay(.white.opacity(0.06))
                    .padding(.leading, 56)

                NewsRow(
                    icon: "flame.fill",
                    title: "Artemis III Update",
                    subtitle: "Mission progress report",
                    url: "https://www.nasa.gov/news/"
                )
            }
            .background(.white.opacity(0.04))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white.opacity(0.08), lineWidth: 0.5)
            )
            .padding(.horizontal, 20)
        }
    }
}

struct NewsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let url: String
    @State private var showSafari = false

    var body: some View {
        Button {
            showSafari = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(width: 32, height: 32)
                    .background(.white.opacity(0.07))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))

                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.35))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.2))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url: URL(string: url)!)
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
