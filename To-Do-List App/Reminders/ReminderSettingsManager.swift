//
//  ReminderSettingsManager.swift
//  To-Do-List App
//
//  Created by David on 14/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

enum ReminderCreationOutcome: String {
    
    case success
    case failure
    
}

class ReminderSettingsManager: ReminderPickerViewDelegate {
    
    var reminderItem: ToDoItem
    let localNotifManager: LocalNotificationManager
    var popupViewPresenter: PopUpViewPresenter?
    
    init(itemForReminding: ToDoItem) {
        self.reminderItem = itemForReminding
        self.localNotifManager = LocalNotificationManager()
    }
    
    func didAskToSetReminderFor(date: Date) {
        reminderItem.reminderDate = date

        localNotifManager.createLocalNotification(forItem: reminderItem) { (outcome) in
            
            if outcome == .success {
                print("Success Creating Notification")
                
                DispatchQueue.main.async {
                    self.popupViewPresenter?.handleDismiss()
                    self.presentOutcomeView(forOutcome: .success)
                }
                // Add a UI element to show shceduled notification on to the cell
            } else if outcome == .failure {
                print("Failure Creating Notification")

                self.presentOutcomeView(forOutcome: .failure)
            
            }
        }
    }
    
    lazy var reminderPickerView: ReminderPickerView = {
        let rpv = ReminderPickerView()
        rpv.backgroundColor = .white
        rpv.layer.cornerRadius = 8
        rpv.delegate = self
        rpv.clipsToBounds = true
        rpv.translatesAutoresizingMaskIntoConstraints = false
        return rpv
    }()
    
    func showSettings() {
        
        self.popupViewPresenter = PopUpViewPresenter(viewToPresent: reminderPickerView, withHeight: 250, withWidth: 300)

    }
    
    fileprivate func presentOutcomeView(forOutcome outcome: ReminderCreationOutcome) {
        
        let outcomeView = ReminderOutcomeView(frame: CGRect.zero, outcome: outcome)

        if let window = UIApplication.shared.keyWindow {

            window.addSubview(outcomeView)
            
            outcomeView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 80, height: 80)
            outcomeView.anchorCenterYToSuperview()
            outcomeView.anchorCenterXToSuperview()
            
            outcomeView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                outcomeView.alpha = 1
            }, completion: { (success) in
                if success {
                    dismissOutcomeView()
                }
            })
        }
        
        func dismissOutcomeView() {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                outcomeView.alpha = 0
            }, completion: { (success) in
                outcomeView.removeFromSuperview()
            })
        }
        
    }

}

