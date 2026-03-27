enum Tabs: CaseIterable {
    case home
    case explore
    case mars
    case neo
    case ar

    var icon: String {
        switch self {
        case .home:    return "house.fill"
        case .explore: return "photo.stack.fill"
        case .mars:    return "globe.americas.fill"
        case .neo:     return "sparkles"
        case .ar:      return "arkit"
        }
    }

    var label: String {
        switch self {
        case .home:    return "Home"
        case .explore: return "Explore"
        case .mars:    return "Mars"
        case .neo:     return "NEOs"
        case .ar:      return "AR"
        }
    }
}
