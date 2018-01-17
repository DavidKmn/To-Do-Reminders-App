//
//  NotificationOutcomeView.swift
//  To-Do-List App
//
//  Created by David on 15/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

class ReminderOutcomeView: UIView {
    
    let outcomeImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var notificationCreationOutcome: ReminderCreationOutcome?
    
    convenience init(frame: CGRect, outcome: ReminderCreationOutcome) {
        self.init(frame: frame)
        
        self.notificationCreationOutcome = outcome
        
        setupComponets()
    }
    
    private func setupComponets() {
        
        guard let outcome = notificationCreationOutcome else { return }
        
        addSubview(outcomeImageView)
        
        outcomeImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: self.frame.width, height: self.frame.height)
        outcomeImageView.anchorCenterXToSuperview()
        outcomeImageView.anchorCenterYToSuperview()
        
        switch outcome {
        case .success:
            outcomeImageView.tintColor = UIColor.success
            outcomeImageView.image = #imageLiteral(resourceName: "success").withRenderingMode(.alwaysTemplate)
            break
        case .failure:
            outcomeImageView.tintColor = UIColor.failure
            outcomeImageView.image = #imageLiteral(resourceName: "failure").withRenderingMode(.alwaysTemplate)
            break
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
