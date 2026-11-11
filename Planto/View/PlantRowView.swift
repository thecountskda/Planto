import SwiftUI

struct PlantRowView: View {
    
    var room: String
    var name: String
    var light: String
    var water: String
    
    var isWatered: Bool
    var onToggle: () -> Void
    
    
    var body: some View {
        
        
        HStack(spacing: 12) {
            Button {
                onToggle()
            } label: {
                Image(systemName: isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isWatered ? Color.green : Color.secondary)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                    Text("in \(room)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                Text(name)
                    .font(.title3)
                
                HStack {
                    TagView(icon: "sun.max", text: light)
                    TagView(icon: "drop", text: water)
                }
                
            }
            
            Spacer()
        }
        .padding()}
}

#Preview {
    PlantRowView(room: "Kitchen", name: "Monstera", light: "Full sun", water: "20-50 ml", isWatered: false, onToggle: {})
        .preferredColorScheme(.dark)
}
