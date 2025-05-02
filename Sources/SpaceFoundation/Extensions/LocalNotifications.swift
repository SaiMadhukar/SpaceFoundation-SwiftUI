import UserNotifications
import Foundation

public protocol FoundationLocalNotifications {
    
    var status: UNAuthorizationStatus { get }
    func requestAuthroizationStatus() async -> UNAuthorizationStatus
    func requestAuthorization() async -> Bool
    func removeAllActivityNotifications()
}

public class LocalNotifications {
    
    public var status: UNAuthorizationStatus = .notDetermined
    
    public init() {}
    
    public func requestAuthroizationStatus() async -> UNAuthorizationStatus {
        await withCheckedContinuation { continuation in
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                self.status = settings.authorizationStatus
                continuation.resume(returning: settings.authorizationStatus)
            }
        }
    }
    
    public func requestAuthorization() async -> Bool {
       await withCheckedContinuation { continuation in
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
               continuation.resume(returning: granted)
           }
       }
    }
    
    public func removeAllActivityNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
