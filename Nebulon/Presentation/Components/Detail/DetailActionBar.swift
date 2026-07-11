import SwiftUI

struct DetailActionBar: View {
    var onCopy: () -> Void = {}
    var onShare: () -> Void = {}
    var onWallpaper: () -> Void = {}

    var body: some View {
        HStack(spacing: Design.itemSpacing) {
            ActionButton(icon: "document.on.document", label: "Copy", action: onCopy)
            ActionButton(icon: "square.and.arrow.up", label: "Share", action: onShare)
            ActionButton(icon: "arrow.down.to.line", label: "Wallpaper", action: onWallpaper)
        }
        .padding(.horizontal, Design.contentPadding)
        .padding(.vertical, Design.cardRadius)
    }
}
