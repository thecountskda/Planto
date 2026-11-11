import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = PlantViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("My Plants 🌱")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            ZStack(alignment: .bottomTrailing){
                
                List {
                    ForEach(viewModel.plants) { plant in
                        PlantRowView(
                            room: plant.room,
                            name: plant.name,
                            light: plant.light,
                            water: plant.water,
                            isWatered: plant.isWatered,
                            onToggle: {
                                viewModel.toggleWatered(plant)
                            }
                        )
                        .swipeActions {
                            Button(role: .destructive) {
                                
                                //.destructive makes the button red and gives the delete animation for free.
                                
                                viewModel.deletePlant(plant)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                
                /*  ScrollView {
                 VStack(spacing: 0) {
                 
                 /* PlantRowView(room: "Kitchen", name: "Monstera", light: "Full sun", water: "20-50 ml")
                  Divider()
                  PlantRowView(room: "Bedroom", name: "Pothos", light: "Full sun", water: "20-50 ml")
                  Divider()
                  PlantRowView(room: "Living Room", name: "Orchid", light: "Full sun", water: "20-50 ml")*/
                 
                 
                 //I replace the previews with this new code:
                 
                 ForEach(viewModel.plants) { plant in
                 PlantRowView(room: plant.room, name: plant.name, light: plant.light, water: plant.water)
                 Divider()
                 } */
            }
            
            Button {
                showingSheet = true
                
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.green)
                    .clipShape(Circle())
            }.padding()
        }
        .sheet(isPresented: $showingSheet) {
            SetReminderView(viewModel: viewModel)
        }
    } //this is passing the ViewModel to the sheet
}


#Preview {
    ContentView().preferredColorScheme(.dark)
}
