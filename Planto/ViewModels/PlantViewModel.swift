import Foundation
import Observation

@Observable
class PlantViewModel {
    //var plants: [Plant] = []
    
    //save code
    private let saveKey = "savedPlants"

    var plants: [Plant] = [] {
        didSet {
            save()
        }
    }

    init() {
        load()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedPlants = try? JSONDecoder().decode([Plant].self, from: data) {
            plants = savedPlants
        }
    }
    
    
    
    func addPlant(name: String, room: String, light: String, wateringDay: String, water: String) {
        let newPlant = Plant(name: name, room: room, light: light, wateringDay: wateringDay, water: water)
        plants.append(newPlant)
        NotificationManager.shared.schedule(for: newPlant) //added notification call
    }
    
    func toggleWatered(_ plant: Plant) {
        
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
            
            if plants[index].isWatered {
                plants[index].wateredDate = Date()
                
                NotificationManager.shared.cancel(for: plant)
                NotificationManager.shared.schedule(for: plants[index])
            } else {
                plants[index].wateredDate = nil
            }
        }
    }
    
    //Date() is the current date and time. When you check a plant, we cancel the old notification and schedule a new one, which counts from now.
    
    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        NotificationManager.shared.cancel(for: plant) //added notification call
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
    
    func updatePlant(_ plant: Plant, name: String, room: String, light: String, wateringDay: String, water: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDay = wateringDay
            plants[index].water = water
            
            NotificationManager.shared.cancel(for: plant) //added notification call
            NotificationManager.shared.schedule(for: plants[index])
        }
    }
    
    // this function finds the plant by id, like toggleWatered, and changes its fields. We don’t touch isWatered, so a checked plant stays checked after an edit.
    
    func resetExpiredChecks() {
        let calendar = Calendar.current

        for index in plants.indices {
            if plants[index].isWatered, let date = plants[index].wateredDate {
                let start = calendar.startOfDay(for: date)
                let today = calendar.startOfDay(for: Date())
                let daysPassed = calendar.dateComponents([.day], from: start, to: today).day ?? 0

                if daysPassed >= plants[index].intervalDays {
                    plants[index].isWatered = false
                    plants[index].wateredDate = nil
                } //0 to test the code
            }
        }
        
        /*
         - plants.indices gives the positions 0, 1, 2..., so we can change items in place.
         - startOfDay removes the time, so we compare calendar days and not hours. A plant watered at 11 pm on a daily schedule resets at midnight, not 24 hours later.
         - if isWatered, let date = ... checks two things at once: it’s checked, and it has a date.
         - The ?? 0 is the nil-coalescing operator again, giving a safe fallback if the calculation fails.8
         */
        
        
    }
    
}





/*
 -  firstIndex(where:) finds the position of the plant in the array by its id.
 
 -  .toggle() flips a Bool: false becomes true, and true becomes false.
 
 -  removeAll { $0.id == plant.id } removes every plant whose id matches. $0 means “the current item” in this short closure.
 */
