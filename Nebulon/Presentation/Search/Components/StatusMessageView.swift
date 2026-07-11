import SwiftUI

struct StatusMessageView<Action: View>: View {
    let icon: String
    let title: String
    let message: String
    @ViewBuilder var action: () -> Action

    init(
        icon: String,
        title: String,
        message: String,
        @ViewBuilder action: @escaping () -> Action = { EmptyView() }
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action
    }

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 44))
                .foregroundStyle(.white.opacity(0.25))

            Text(title)
                .font(Design.statusTitleFont)
                .foregroundStyle(.white.opacity(0.8))

            Text(message)
                .font(Design.statusMessageFont)
                .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
                .multilineTextAlignment(.center)

            action()
                .padding(.top, 6)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
        .padding(.horizontal, 32)
    }
}
