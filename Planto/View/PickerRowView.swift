import SwiftUI

struct PickerRowView: View {
    var icon: String
    var title: String
    @Binding var selection: String
    var options: [String]

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text(item)
                }
            }
            .tint(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    PickerRowView(
        icon: "location",
        title: "Room",
        selection: .constant("Bedroom"),
        options: ["Bedroom", "Kitchen"]
    )
    .preferredColorScheme(.dark)
}
