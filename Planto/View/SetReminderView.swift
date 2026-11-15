import SwiftUI

struct SetReminderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var viewModel: PlantViewModel
    
    var plantToEdit: Plant? = nil //nil means “we’re adding a new plant”, and a value means “we’re editing this one”.
    
    @State private var plantName: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDay: String
    @State private var water: String

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial Sun", "Low Light"]
    let WateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let Water = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    
    
    
    init(viewModel: PlantViewModel, plantToEdit: Plant? = nil) {
        self.viewModel = viewModel
        self.plantToEdit = plantToEdit
        _plantName = State(initialValue: plantToEdit?.name ?? "")
        _room = State(initialValue: plantToEdit?.room ?? "Bedroom")
        _light = State(initialValue: plantToEdit?.light ?? "Full sun")
        _wateringDay = State(initialValue: plantToEdit?.wateringDay ?? "Every day")
        _water = State(initialValue: plantToEdit?.water ?? "20-50 ml")
    }
    
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
                        if let plantToEdit {
                            viewModel.updatePlant(plantToEdit, name: plantName, room: room, light: light, wateringDay: wateringDay, water: water)
                        } else {
                            viewModel.addPlant(name: plantName, room: room, light: light, wateringDay: wateringDay, water: water)
                        }
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
         
            if let plantToEdit {
                Button {
                    viewModel.deletePlant(plantToEdit)
                    dismiss()
                } label: {
                    Text("Delete Reminder")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
            }
            
        }
    }
}

#Preview {
    SetReminderView(
        viewModel: PlantViewModel(),
        plantToEdit: Plant(name: "Pothos", room: "Kitchen", light: "Low Light", wateringDay: "Every 3 days", water: "50-100 ml")
    )
    .preferredColorScheme(.dark)
}
