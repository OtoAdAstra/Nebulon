import SwiftUI

struct DetailItem: Identifiable {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var id: String { label }
}
