import Foundation
import Observation

@Observable
class PlantViewModel {
    var plants: [Plant] = []

    func addPlant(name: String, room: String, light: String, wateringDay: String, water: String) {
        let newPlant = Plant(name: name, room: room, light: light, wateringDay: wateringDay, water: water)
        plants.append(newPlant)
    }
    
    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
    
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var progress: Double {
        if plants.isEmpty { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var headerMessage: String {
        if wateredCount == 0 {
            return "Your plants are waiting for a sip 💦"
        } else {
            return "\(wateredCount) of your plants feel loved today ✨"
        }
    }
    
    var allDone: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }
    
    
}





/*
-  firstIndex(where:) finds the position of the plant in the array by its id.
 
-  .toggle() flips a Bool: false becomes true, and true becomes false.
 
-  removeAll { $0.id == plant.id } removes every plant whose id matches. $0 means “the current item” in this short closure.
 */
