import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error {
                print("Permission error: \(error)")
            }
        }
    }

    func schedule(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your \(plant.name)"
        content.sound = .default

       let seconds = Double(plant.intervalDays) * 24 * 60 * 60
        //let seconds = 60.0
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    func cancel(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
}

/*
 
 - static let shared creates one shared instance for the whole app, so you call NotificationManager.shared.schedule(...) from anywhere without creating objects.
 - Permission: iOS requires the user to allow notifications first. It shows the system pop-up once.
 - A notification has three parts: the content (what it says), the trigger (when it fires), and the request that combines them with an identifier.
 - We use the plant’s id as the identifier, so we can cancel or replace that plant’s notification later.
 - repeats: true makes it fire again every interval. iOS requires at least 60 seconds for repeating triggers.
 
 */
