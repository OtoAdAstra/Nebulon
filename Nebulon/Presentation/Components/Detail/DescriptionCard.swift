import SwiftUI

struct DescriptionCard: View {
    let text: String

    @State private var isExpanded = false

    private let collapsedLineLimit = 4
    private let linkColor = Color(red: 0.3, green: 0.6, blue: 1.0)

    var body: some View {
        InfoCard(title: "Description") {
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))
                .lineSpacing(5)
                .lineLimit(isExpanded ? nil : collapsedLineLimit)

            Button(isExpanded ? "Show less" : "Read more") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(linkColor)
        }
    }
}
