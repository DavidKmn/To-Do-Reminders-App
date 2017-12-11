//
//  ViewController.swift
//  To-Do-List App
//
//  Created by David on 11/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let toDoItem = ToDoItem(title: "Read News", completed: false, createdAt: Date(), itemIdentifier: UUID())
        
        let toDos = FileStorageManager.loadAll(ToDoItem.self)
        
        print(toDos)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

