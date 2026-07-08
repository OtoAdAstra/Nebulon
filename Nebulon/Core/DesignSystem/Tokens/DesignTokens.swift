import SwiftUI

enum Design {

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
    static let cardBackgroundOpacity: CGFloat = 0.6

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

    /// Size of dismiss/back buttons (circle diameter)
    static let dismissButtonSize: CGFloat = 42

    // MARK: - Search

    /// Height of the glass search bar; the round cancel button matches it
    static let searchBarHeight: CGFloat = 46

    /// Horizontal padding inside the search field capsule
    static let searchFieldPadding: CGFloat = 14

    /// Minimum column width for suggestion chips in the Discover grid
    static let chipMinWidth: CGFloat = 130

    /// Horizontal padding inside tag/suggestion chips
    static let chipHorizontalPadding: CGFloat = 14

    /// Vertical padding inside tag/suggestion chips
    static let chipVerticalPadding: CGFloat = 9

    /// Bottom content inset so scrolling content clears the floating tab bar
    static let tabBarClearance: CGFloat = 120

    /// Fill opacity for image placeholders while media loads
    static let imagePlaceholderOpacity: CGFloat = 0.06

    /// Height of the fade-out gradient at the bottom of detail hero images
    static let heroFadeHeight: CGFloat = 70

    // MARK: - Glass Fallback (pre-iOS 26)

    /// Stroke opacity for material-fallback outlines (search bar, round buttons)
    static let glassStrokeOpacity: CGFloat = 0.2

    /// Stroke width for material-fallback outlines
    static let glassStrokeWidth: CGFloat = 0.3
}
