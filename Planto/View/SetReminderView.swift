import SwiftUI

struct SetReminderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var viewModel: PlantViewModel
    
    @State private var plantName = ""
    
    @State private var room = "Bedroom"
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
   
    
    @State private var light = "Full sun"
    let lights = ["Full sun", "Partial Sun", "Low Light"]
    
    @State private var wateringDay = "Every day"
    let WateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    
    @State private var water = "20-50 ml"
    let Water = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    
    var body: some View {
        VStack (spacing: 16) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                
                Spacer()
                Text("Set Reminder")
                    .font(.headline)
                Spacer()
                
                Button {
                    if !plantName.isEmpty {
                        viewModel.addPlant(
                            name: plantName,
                            room: room,
                            light: light,
                            wateringDay: wateringDay,
                            water: water
                        )
                        dismiss()
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .foregroundStyle(.white)
            .padding()
            
            HStack {
                Text("Plant Name")
                TextField("Pothos", text: $plantName)
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            VStack(spacing: 0) {
                PickerRowView(icon: "location", title: "Room", selection: $room, options: rooms)
                
                Divider()//makes a line
                
                PickerRowView(icon: "sun.max", title: "Light", selection: $light, options: lights)
            }
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            VStack(spacing: 0) {
                PickerRowView(icon: "drop", title: "Watering Days", selection: $wateringDay, options: WateringDays)
                Divider()
                PickerRowView(icon: "drop", title: "Water", selection: $water, options: Water)
            }
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    SetReminderView(viewModel: PlantViewModel())
        .preferredColorScheme(.dark)
}
