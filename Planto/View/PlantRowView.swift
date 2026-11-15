import SwiftUI

struct PlantRowView: View {
    
    var room: String
    var name: String
    var light: String
    var water: String
    
    var isWatered: Bool
    var onToggle: () -> Void
    
    var lightIcon: String {
        switch light {
        case "Full sun": return "sun.max"
        case "Partial Sun": return "sun.min"
        case "Low Light": return "moon"
        default: return "sun.max"
        }
    }
    
    var body: some View {
        
        
        HStack(spacing: 12) {
            Button {
                onToggle()
            } label: {
                Image(systemName: isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isWatered ? Color.green2 : Color.secondary)
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
                    .font(.title)
                
                HStack {
                    TagView(icon: lightIcon, text: light).foregroundStyle(Color.light)
                    TagView(icon: "drop", text: water).foregroundStyle(Color.water)
                }
                
            }.opacity(isWatered ? 0.5 : 1)//if the plant is watered, use 0.5 (half transparent), otherwise 1 (fully visible).
            .animation(.easeInOut, value: isWatered)//a smooth fade
            
            
            Spacer()
        }
        .padding()}
}

#Preview {
    PlantRowView(room: "Kitchen", name: "Monstera", light: "Full sun", water: "20-50 ml", isWatered: false, onToggle: {})
        .preferredColorScheme(.dark)
}
