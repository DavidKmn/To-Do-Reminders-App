//
//  ItemCreationView.swift
//  To-Do-List App
//
//  Created by David on 16/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

protocol ItemCreationViewDelegate: class {
    func didTapOnCreateItem(withTitle title: String) -> (Bool)
}

class ItemCreationView: UIView {
    
    weak var delegate: ItemCreationViewDelegate?
    
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.lightBlue
        lbl.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        lbl.textColor = .white
        lbl.text = "Enter Task Name"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let taskNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "e.g. Buy Groceries ..."
        tf.clearButtonMode = .always
        return tf
    }()
    
    lazy var createButton: UIButton = {
        return newButton(withTitle: "Create", selector: #selector(handleCreateTap))
    }()
    
    lazy var cancelButton: UIButton = {
        return newButton(withTitle: "Cancel", selector: #selector(handleCancelTap))
    }()
    
    let userInputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUIComponenets()
    }
    
    fileprivate func setupUIComponenets() {
        
        addSubview(infoLabel)
        
        infoLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 40)
        
        let actionsStackView = UIStackView(arrangedSubviews: [cancelButton, createButton])
        actionsStackView.axis = .horizontal
        actionsStackView.distribution = .fillEqually
        actionsStackView.spacing = 10
        
        addSubview(actionsStackView)
        
        actionsStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topPadding: 0, leadingPadding: 10, bottomPadding: 10, trailingPadding: 10, width: 0, height: 40)
        
        
        addSubview(userInputContainer)
        
        userInputContainer.anchor(top: infoLabel.bottomAnchor, leading: leadingAnchor, bottom: actionsStackView.topAnchor, trailing: trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 0)
        
        
        userInputContainer.addSubview(taskNameField)
        
        taskNameField.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, topPadding: 0, leadingPadding: 10, bottomPadding: 0, trailingPadding: 10, width: 0, height: 30)
        taskNameField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    @objc private func handleCreateTap() {
        if let title = taskNameField.text {
            let success = delegate?.didTapOnCreateItem(withTitle: title)
            if success == true {
                taskNameField.text = nil
            }
        }
    }
    
    fileprivate func newButton(withTitle title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.lightBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    @objc private func handleCancelTap() {
        NotificationCenter.default.post(name: Constants.NotificationNames.cancelPopover, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
