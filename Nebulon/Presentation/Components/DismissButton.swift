import SwiftUI

struct DismissButton: View {
    let icon: String
    let action: () -> Void

    init(_ icon: String = "xmark", action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: Design.dismissButtonSize, height: Design.dismissButtonSize)
                .background(.ultraThinMaterial, in: Circle())
                .padding()
        }
    }
}
