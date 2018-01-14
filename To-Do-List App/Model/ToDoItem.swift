//
//  ToDoItem.swift
//  To-Do-List App
//
//  Created by David on 11/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    
    var title: String
    var completed: Bool
    var createdAt: Date
    var itemIdentifier: UUID
    var reminderDate: Date
    
    func saveItem() {
        FileStorageManager.save(self, with: itemIdentifier.uuidString  )
    }
    
    func deleteItem() {
        FileStorageManager.delete(itemIdentifier.uuidString)
    }
    
    mutating func markAsCompleted() {
        self.completed = true
        FileStorageManager.save(self, with: itemIdentifier.uuidString)
    }
    
    mutating func markAsUncompleted() {
        self.completed = false
        FileStorageManager.save(self, with: itemIdentifier.uuidString)
    }
    
}
