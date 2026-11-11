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
            
            if !viewModel.plants.isEmpty {
                VStack(spacing: 12) {
                    Text(viewModel.headerMessage)
                        .font(.subheadline)
                    ProgressBarView(progress: viewModel.progress)
                }
                .padding()
            }
            
            //Your design’s bar is thinner and the text is centered. Experiment with .frame(height:) and .multilineTextAlignment(.center) or .frame(maxWidth: .infinity) on the text until it matches.
            
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
                
                //old code folded
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
