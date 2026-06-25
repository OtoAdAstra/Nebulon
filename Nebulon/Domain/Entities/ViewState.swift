enum ViewState: Equatable {
    case idle
    case loading
    case dataLoaded
    case loaded
    case error(String)
}
