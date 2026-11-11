import SwiftUI

struct TagView: View {
    var icon: String
    var text: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.caption2)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
    }
}

#Preview {
    TagView(icon: "sun.max", text: "Full sun")
        .preferredColorScheme(.dark)
}
