//
//  ReminderSettingsManager.swift
//  To-Do-List App
//
//  Created by David on 14/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class ReminderSettingsManager: ReminderPickerViewDelegate {
    
    var reminderItem: ToDoItem
    let localNotifManager: LocalNotificationManager
    
    init(itemForReminding: ToDoItem) {
        self.reminderItem = itemForReminding
        self.localNotifManager = LocalNotificationManager()
    }
    
    func didAskToSetReminderFor(date: Date) {
        reminderItem.reminderDate = date

        localNotifManager.createLocalNotification(forItem: reminderItem) { (success) in
            if success {
                print("Success Creating Notification")
                
                // Pressent Success Screen
                
                // Add a UI element to show shceduled notification on to the cell
            } else {
                print("Failure Creating Notification")
                // Present Error Screen
            }
        }
    }
    
    let blackView = UIView()
    
    lazy var reminderPickerView: ReminderPickerView = {
        let rpv = ReminderPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        rpv.backgroundColor = .white
        rpv.layer.cornerRadius = 8
        rpv.delegate = self
        rpv.clipsToBounds = true
        rpv.translatesAutoresizingMaskIntoConstraints = false
        return rpv
    }()
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(reminderPickerView)
            
            reminderPickerView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            reminderPickerView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            
            blackView.frame = window.frame
            blackView.alpha = 0
            reminderPickerView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 1
                self.reminderPickerView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc fileprivate func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            self.reminderPickerView.alpha = 0
        }) { (completed) in
            if completed {
                self.blackView.removeFromSuperview()
                self.reminderPickerView.removeFromSuperview()
            }
        }
    }
}

