import SwiftUI

struct ContentView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("My Plants 🌱")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
         
        ZStack(alignment: .bottomTrailing){
            
                ScrollView {
                    VStack(spacing: 0) {
                        PlantRowView(room: "Kitchen", name: "Monstera", light: "Full sun", water: "20-50 ml")
                        Divider()
                        PlantRowView(room: "Bedroom", name: "Pothos", light: "Full sun", water: "20-50 ml")
                        Divider()
                        PlantRowView(room: "Living Room", name: "Orchid", light: "Full sun", water: "20-50 ml")
                    }
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
        }.sheet(isPresented: $showingSheet) {
            SetReminderView()
        }
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}
