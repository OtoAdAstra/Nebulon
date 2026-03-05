// Presentation/Home/ContentView.swift

import SwiftUI

struct HomeView: View {
    let viewModel: APODViewModel

    var body: some View {
        ZStack {
            StarfieldBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    APODCardView(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding()
            }
            
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    HomeView(viewModel: APODViewModel(fetchAPODUseCase: FetchAPODUseCase(repository: APODRepository(client: NetworkClient()))))
}
