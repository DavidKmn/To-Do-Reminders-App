//
//  ToDoListCell.swift
//  To-Do-List App
//
//  Created by David on 15/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

protocol ToDoListCellDelegate: class {
    
    func didCompleteToDoItem(_ cell: ToDoListCell)
    func didUncompleteToDoItem(_ cell: ToDoListCell)
    
}

class ToDoListCell: UITableViewCell {
    
    weak var delegate: ToDoListCellDelegate?
    
    static let cellId = "toDoListCellId"
    
    var viewModel: ToDoItemViewModel? {
        didSet{
            self.itemNameLabel.text = viewModel?.title
            viewModel?.setupCheckBox(forCell: self)
        }
    }
    
    
    var isChecked: Bool = false {
        didSet{
            if isChecked {
                checkBoxButton.setImage(#imageLiteral(resourceName: "tickedBox"), for: .normal)
            } else {
                checkBoxButton.setImage(#imageLiteral(resourceName: "untickedBox"), for: .normal)
            }
        }
    }
    
    lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(#imageLiteral(resourceName: "untickedBox"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleTaskCompletetion), for: .touchUpInside)
        return button
    }()
    
    let itemNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Task name goes here"
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIElements()
        
    }
    
    fileprivate func setupUIElements() {
        
        let cellWidth = self.frame.size.width
        
        addSubview(checkBoxButton)
        checkBoxButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 70, height: 70)
        checkBoxButton.anchorCenterYToSuperview()
        
        addSubview(itemNameLabel)
        itemNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, topPadding: 4, leadingPadding: 8, bottomPadding: 4, trailingPadding: 0, width: cellWidth * 0.6, height: 0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        super.contentView.backgroundColor = .white
    }
    
    @objc fileprivate func handleTaskCompletetion() {
        if let delegate = self.delegate {
            if isChecked {
                delegate.didUncompleteToDoItem(self)
            } else {
                delegate.didCompleteToDoItem(self)
            }
            isChecked = !isChecked
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
}







