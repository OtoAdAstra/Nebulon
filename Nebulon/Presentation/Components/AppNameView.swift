import SwiftUI

struct AppNameView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("Nebulon")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(6)
                .background(
                    Circle()
                        .fill(Color("DarkSpace"))
                )
                .overlay(
                    Circle()
                        .stroke(.blue.opacity(0.6), lineWidth: 1.5)
                )

            VStack(alignment: .leading, spacing: 1) {
                Text("Nebulon")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Text("EXPLORER")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.blue.opacity(0.7))
            }
        }
    }
}
