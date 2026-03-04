import SwiftUI

struct ContentView: View {
    @State private var viewModel = APODViewModel(
            fetchAPODUseCase: FetchAPODUseCase(
                repository: APODRepository(
                    client: NetworkClient()
                )
            )
        )

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.apod?.title ?? "")
                        .font(.title2.bold())
                    Text(viewModel.apod?.explanation ?? "")
                        .font(.body)
                }
                .padding()
            }
            .task {
                await viewModel.onAppear()
            }
        }
}

#Preview {
    ContentView()
}
