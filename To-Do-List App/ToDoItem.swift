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
    
    func saveItem() {
        
    }
    
    func deleteItem() {
        
        
    }
    
    func marketAsCompleted() {
        
        
    }
}
