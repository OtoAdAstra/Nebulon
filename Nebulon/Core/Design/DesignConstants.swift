import SwiftUI

enum Design {

    // MARK: - Global

    /// Horizontal padding for section headers (e.g. "Solar System", "News")
    static let sectionPadding: CGFloat = 28

    /// Horizontal padding for content blocks (e.g. APOD description, details cards)
    static let contentPadding: CGFloat = 12

    /// Default spacing between items in stacks and grids
    static let itemSpacing: CGFloat = 12

    /// Standard card corner radius (news cards, description cards, stat cards)
    static let cardRadius: CGFloat = 16

    /// Opacity for thin border strokes on cards
    static let borderOpacity: CGFloat = 0.1

    /// Stroke width for card borders
    static let borderWidth: CGFloat = 0.5

    /// Opacity for subtle card background fills
    static let cardBackgroundOpacity: CGFloat = 0.05

    /// Opacity for secondary text (e.g. planet subtitle, stat labels)
    static let secondaryTextOpacity: CGFloat = 0.45

    /// Opacity for tertiary/dimmer text (e.g. dates, less important labels)
    static let tertiaryTextOpacity: CGFloat = 0.5

    // MARK: - APODView

    /// Large hero card corner radius (APOD card on home screen)
    static let heroRadius: CGFloat = 34

    /// Aspect ratio for the APOD card on the home screen (width:height)
    static let apodAspectRatio: CGFloat = 1.2

    /// Hero image takes this fraction of screen height in APOD detail view
    static let heroImageRatio: CGFloat = 0.6

    // MARK: - SolarSystem

    /// Width and height of each planet card in the carousel
    static let planetCardSize: CGFloat = 130

    /// Planet card corner radius in the solar system carousel
    static let planetCardRadius: CGFloat = 22

    /// Height of the 3D planet model in planet detail view
    static let planet3DHeight: CGFloat = 380

    // MARK: - DismissButton

    /// Size of dismiss/back buttons (circle diameter)
    static let dismissButtonSize: CGFloat = 42
}

// MARK: - View Modifiers

/// Applies ultraThinMaterial background + rounded clip + subtle border stroke.
/// Used for frosted glass cards (news, planet cards, tab bar).
struct MaterialCardModifier: ViewModifier {
    var cornerRadius: CGFloat = Design.cardRadius

    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(Design.borderOpacity), lineWidth: Design.borderWidth)
            )
    }
}

/// Applies a translucent dark background + rounded clip.
/// Used for content cards (APOD description, details).
struct CardBackgroundModifier: ViewModifier {
    var cornerRadius: CGFloat = Design.cardRadius

    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(Design.cardBackgroundOpacity))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    /// Frosted glass card style with material background and border
    func materialCard(cornerRadius: CGFloat = Design.cardRadius) -> some View {
        modifier(MaterialCardModifier(cornerRadius: cornerRadius))
    }

    /// Subtle translucent card background
    func cardBackground(cornerRadius: CGFloat = Design.cardRadius) -> some View {
        modifier(CardBackgroundModifier(cornerRadius: cornerRadius))
    }
}
