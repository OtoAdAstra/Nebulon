import SwiftUI

/// The Copy / Share / Wallpaper row under a detail hero.
/// Actions default to no-ops until the features are wired up —
/// then both APOD and search details get them in one place.
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
