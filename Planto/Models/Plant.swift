import Foundation

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDay: String
    var water: String
    var isWatered = false
    var wateredDate: Date? = nil
    
    //With let id = UUID(), Swift can’t restore the saved id and would make a new id every launch.
    
    //Date? is an optional date: nil means “never watered,” and a value means “watered at this moment.”
    
    var intervalDays: Int {
        switch wateringDay {
        case "Every day": return 1
        case "Every 2 days": return 2
        case "Every 3 days": return 3
        case "Once a week": return 7
        case "Every 10 days": return 10
        case "Every 2 weeks": return 14
        default: return 1
        }
        //to send a number to notification  
    }
}


