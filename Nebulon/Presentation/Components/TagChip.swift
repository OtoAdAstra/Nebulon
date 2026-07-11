import SwiftUI

struct TagChip: View {
    let title: String
    var icon: String? = nil
    var fillsWidth: Bool = false
    var onTap: (() -> Void)? = nil

    var body: some View {
        Group {
            if let onTap {
                Button(action: onTap) { label }
                    .buttonStyle(.plain)
            } else {
                label
            }
        }
    }

    private var label: some View {
        HStack(spacing: 6) {
            if let icon {
                Image(systemName: icon)
                    .font(Design.chipIconFont)
                    .foregroundStyle(Color("LightCyan"))
            }
            Text(title)
                .font(Design.chipFont)
                .foregroundStyle(.white.opacity(0.85))
                .lineLimit(1)
        }
        .frame(maxWidth: fillsWidth ? .infinity : nil)
        .padding(.horizontal, Design.chipHorizontalPadding)
        .padding(.vertical, Design.chipVerticalPadding)
        .background {
            Capsule()
                .fill(.ultraThinMaterial.opacity(Design.cardBackgroundOpacity))
                .overlay {
                    Capsule()
                        .stroke(.white.opacity(Design.borderOpacity), lineWidth: Design.borderWidth)
                }
        }
    }
}
