//
//  ToDoItemViewModel.swift
//  To-Do-List App
//
//  Created by David on 15/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

protocol ToDoItemViewModel {
    
    var title: String { get }
    var completed: Bool { get }
    func setupCheckBox(forCell cell: ToDoListCell)
    
}

class ToDoItemViewModelFromItem: ToDoItemViewModel {
    
    let toDoItem: ToDoItem
    
    var title: String
    var completed: Bool
    
    
    init(withItem item: ToDoItem) {
        self.toDoItem = item
        
        self.title = item.title
        self.completed = item.completed
    }
    
    func setupCheckBox(forCell cell: ToDoListCell) {
        if completed {
                cell.itemNameLabel.attributedText = strikeThroughText(toDoItem.title)
                cell.checkBoxButton.setImage(#imageLiteral(resourceName: "tickedBox"), for: .normal)
            } else {
                cell.itemNameLabel.text = toDoItem.title
                cell.checkBoxButton.setImage(#imageLiteral(resourceName: "untickedBox"), for: .normal)
        }
    }
    
    private func strikeThroughText(_ text: String) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
}
