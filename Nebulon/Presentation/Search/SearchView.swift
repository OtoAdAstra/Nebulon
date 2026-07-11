import SwiftUI

struct SearchView: View {
    var coordinator: SearchCoordinator

    var body: some View {
        ZStack {
            switch coordinator.route {
                case .list:
                    SearchListView(viewModel: coordinator.searchViewModel) { media in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.showDetail(media)
                        }
                    }
                    .transition(.move(edge: .leading))

                case .detail(let media):
                    MediaDetailView(media: media) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.dismissDetail()
                        }
                    }
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
