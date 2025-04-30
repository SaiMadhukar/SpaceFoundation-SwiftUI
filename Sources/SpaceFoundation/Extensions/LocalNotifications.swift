//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 3/27/25.
//

import Foundation
import UserNotifications
import SwiftUICore
//
//public struct  {
//    
//    var name: String
//    var frequency: [WeekDays] = WeekDays.allCases
//}
//
//class LocalNotifications<>: ObservableObject {
//    
//    private var hasAccess: Bool = false
//    private var uuidString: String = ""
//    
//    public init() {
//        uuidString = UUID().uuidString
//    }
//    
//    public func checkAuthentication() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [self] success, error in
//            self.hasAccess = success
//        }
//    }
//    
//    public func scheduleNotifications(with activity: Activity) {
//        let notificationCenter = UNUserNotificationCenter.current()
//        let activity = createNotificationFor(activity: activity)
//    }
//    
//    public func createNotificationFor(activity: Activity) -> UNNotificationRequest {
//        let content = UNMutableNotificationContent()
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 0
//        dateComponents.minute = 30
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        content.title = "Completed the \(activity.name) activity today?"
//        
//        return request
//    }
//}
