enum Tabs: CaseIterable {
    case home
    case search
    case view
    case ai
    case profile

    var icon: String {
        switch self {
            case .home:    return "house.fill"
            case .search: return "magnifyingglass"
            case .view:    return "viewfinder"
            case .ai:     return "sparkles"
            case .profile: return "person.crop.circle"
        }
    }

    var label: String {
        switch self {
            case .home:    return "Home"
            case .search: return "Search"
            case .view:    return "View"
            case .ai:     return "LAIKA"
            case .profile: return "Me"
        }
    }
}
