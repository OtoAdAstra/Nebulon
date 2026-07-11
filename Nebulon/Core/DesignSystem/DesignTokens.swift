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

    // MARK: - Typography
    // Semantic text styles (.footnote, .caption…) instead of fixed sizes,
    // so every label scales with the user's Dynamic Type setting

    /// Monospaced section headers ("DISCOVER", "SOLAR SYSTEM")
    static let sectionHeaderFont: Font = .system(.headline, design: .monospaced, weight: .bold)

    /// Primary line on grid/carousel cards
    static let cardTitleFont: Font = .footnote.weight(.semibold)

    /// Secondary line on cards (dates, subtitles)
    static let cardCaptionFont: Font = .caption2

    /// Small pill badges (e.g. "Astronomy Picture of the Day")
    static let badgeFont: Font = .caption2.weight(.semibold)

    /// Chip labels (suggestions, keywords)
    static let chipFont: Font = .subheadline.weight(.medium)

    /// Icons inside chips
    static let chipIconFont: Font = .caption.weight(.medium)

    /// Row title / subtitle in lists (news)
    static let rowTitleFont: Font = .subheadline.weight(.medium)
    static let rowSubtitleFont: Font = .caption2

    /// Disclosure chevrons in rows
    static let disclosureFont: Font = .caption.weight(.semibold)

    /// Meta text (result counts, timestamps)
    static let metaFont: Font = .footnote

    /// Emphasized button labels ("Try Again")
    static let actionLabelFont: Font = .subheadline.weight(.semibold)

    /// Icons in the search bar (magnifier, clear, cancel)
    static let searchIconFont: Font = .callout.weight(.medium)

    /// Action bar under detail heroes (Copy / Share / Wallpaper)
    static let actionIconFont: Font = .callout.weight(.medium)
    static let actionCaptionFont: Font = .caption.weight(.medium)

    /// Icons in detail-card rows
    static let detailIconFont: Font = .subheadline

    /// Tab bar icon and label
    static let tabIconFont: Font = .title2
    static let tabLabelFont: Font = .caption.weight(.medium)

    /// Dismiss/back circular button icon
    static let dismissIconFont: Font = .title2.weight(.semibold)

    /// Empty/error state title and message
    static let statusTitleFont: Font = .headline
    static let statusMessageFont: Font = .subheadline

    /// Brand tagline in the header lockup — fixed size, pure branding
    static let brandTaglineFont: Font = .system(size: 9, weight: .bold)

    // MARK: - Glass Fallback (pre-iOS 26)

    /// Stroke opacity for material-fallback outlines (search bar, round buttons)
    static let glassStrokeOpacity: CGFloat = 0.2

    /// Stroke width for material-fallback outlines
    static let glassStrokeWidth: CGFloat = 0.3
}
