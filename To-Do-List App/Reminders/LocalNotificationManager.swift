//
//  LocalNotificationManager.swift
//  To-Do-List App
//
//  Created by David on 13/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    
    fileprivate func setupNotification(_ item: ToDoItem, completionHandler: @escaping (_ success: ReminderCreationOutcome) -> ()) {
        
        let notification = UNMutableNotificationContent()
        notification.title = "To-Do Item: \"\(item.title)\" Is Due"
        
        guard let reminderDate = item.reminderDate else { return }
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminderDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(identifier: item.itemIdentifier.uuidString, content: notification, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add the notification: \(error)")
                completionHandler(.failure)
                return
            }
            print("Notifcation Added for \(reminderDate)")
            completionHandler(.success)
        }
    }
    
    func createLocalNotification(forItem item: ToDoItem, completionHandler: @escaping (_ success: ReminderCreationOutcome) -> ()) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    
                    self.setupNotification(item, completionHandler: completionHandler)
                })
            case .authorized:
                self.setupNotification(item, completionHandler: completionHandler)
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
        
    }
    
    fileprivate func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
    
}
