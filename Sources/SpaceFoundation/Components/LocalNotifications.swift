import UserNotifications
import Foundation

public class LocalNotifications {
    public init() {}
    
    public func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    public func scheduleActivityNotification(activity: Activity, hour: Int = 9, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        let (title, body) = notificationContent(for: activity)
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = notificationTrigger(for: activity, hour: hour, minute: minute)
        let request = UNNotificationRequest(identifier: activity._id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func notificationContent(for activity: Activity) -> (String, String) {
        let progress = activity.showEfforts()
        let name = activity.name
        switch activity.goalSetting {
        case .daily:
            return ("Daily Boost!", "🌞 Time for your daily '\(name)'! Progress: \(progress). Let's crush it! 🚀")
        case .weekly:
            return ("Weekly Check-in!", "📅 '\(name)' this week: \(progress). You're on a roll—don't stop now! 🏆")
        case .month:
            return ("Monthly Milestone!", "🌟 '\(name)' this month: \(progress). Finish strong, superstar! ✨")
        }
    }
    
    private func notificationTrigger(for activity: Activity, hour: Int, minute: Int) -> UNNotificationTrigger {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        switch activity.goalSetting {
        case .daily:
            break // every day at selected time
        case .weekly:
            dateComponents.weekday = 2 // Monday
        case .month:
            dateComponents.day = 1 // 1st of every month
        }
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
    
    public func removeAllActivityNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
} 