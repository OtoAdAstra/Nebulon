enum Tabs: CaseIterable {
    case home
    case search
    case mars
    case neo

    var icon: String {
        switch self {
        case .home:    return "house.fill"
        case .search: return "magnifyingglass"
        case .mars:    return "globe.americas.fill"
        case .neo:     return "sparkles"
        }
    }

    var label: String {
        switch self {
        case .home:    return "Home"
        case .search: return "Search"
        case .mars:    return "Mars"
        case .neo:     return "NEOs"
        }
    }
}
