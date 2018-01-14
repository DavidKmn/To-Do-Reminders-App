//
//  ReminderPickerView.swift
//  To-Do-List App
//
//  Created by David on 14/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

protocol ReminderPickerViewDelegate: class {
    func didAskToSetReminderFor(date: Date)
}

class ReminderPickerView: UIView {
    
    weak var delegate: ReminderPickerViewDelegate?
    
    lazy var reminderDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        var currentDate = Date()
        dp.date = currentDate
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "en_GB")
        dp.minimumDate = Date().addingTimeInterval(60)
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Select the Date and Time ..."
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        lbl.backgroundColor = UIColor.lightBlue
        return lbl
    }()
    
    lazy var setReminderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = UIColor.lightBlue
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleSettingReminder), for: .touchUpInside)
        
        return button
    }()
    
    let buttonsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
    }
    
    private func setupElements() {
        
        addSubview(infoLabel)
        
        infoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(buttonsContainerView)
        
        buttonsContainerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        buttonsContainerView.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor).isActive = true
        buttonsContainerView.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupButtons()
        
        addSubview(reminderDatePicker)
    
        reminderDatePicker.topAnchor.constraint(equalTo: infoLabel.bottomAnchor).isActive = true
        reminderDatePicker.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor).isActive = true
        reminderDatePicker.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor).isActive = true
        reminderDatePicker.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true
    
    }
    
    fileprivate func setupButtons() {
        
        buttonsContainerView.addSubview(setReminderButton)
        
        setReminderButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor).isActive = true
        setReminderButton.heightAnchor.constraint(equalTo: buttonsContainerView.heightAnchor).isActive = true
        setReminderButton.widthAnchor.constraint(equalTo: buttonsContainerView.heightAnchor, multiplier: 2).isActive = true
        setReminderButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor).isActive = true
        
    }
    
    @objc private func handleSettingReminder() {
        let reminderDate = reminderDatePicker.date
        delegate?.didAskToSetReminderFor(date: reminderDate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
