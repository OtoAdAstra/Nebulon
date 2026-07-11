import SwiftUI

struct APODErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.25))

            VStack(spacing: 4) {
                Text("Couldn't load today's picture")
                    .font(Design.statusTitleFont)
                    .foregroundStyle(.white.opacity(0.8))

                Text(message)
                    .font(Design.statusMessageFont)
                    .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }

            Button("Try Again", action: onRetry)
                .font(Design.actionLabelFont)
                .foregroundStyle(Color("LightCyan"))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Capsule().stroke(
                                .white.opacity(Design.glassStrokeOpacity),
                                lineWidth: Design.glassStrokeWidth
                            )
                        }
                }
                .buttonStyle(.plain)
                .padding(.top, 6)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .materialCard(cornerRadius: Design.heroRadius)
    }
}
