//
//  ToDoTableViewController.swift
//  To-Do-List App
//
//  Created by David on 14/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

class MainToDoContainerController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoListCellDelegate, InfoContainerViewDelegate {

    var toDoListItems: [ToDoItem]! {
        didSet{
            progressBar.setProgress(progress, animated: true)
        }
    }
    
    lazy var progressBar: UIProgressView = {
        let pgBar = UIProgressView(progressViewStyle: .bar)
        pgBar.tintColor = UIColor.lightBlue
        pgBar.backgroundColor = UIColor.clear
        return pgBar
    }()
    
    var progress: Float {
        if !(toDoListItems.isEmpty) {
            return Float(toDoListItems.filter({ $0.completed == true }).count) / Float(toDoListItems.count)
        } else {
            return 0
        }
    }
    
    lazy var itemsTableView: UITableView = {
        let tv = UITableView()
        tv.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.cellId)
        tv.separatorColor = .clear
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    lazy var infoContainerView: InfoContainerView = {
        let view = InfoContainerView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavBar()
        setupViews()
        loadData()

    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "MY LIST"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupViews() {
        
        let mainViewHeight = view.frame.size.height
        
        view.addSubview(progressBar)
        
        progressBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 1)
    
        view.addSubview(itemsTableView)
        
        itemsTableView.anchor(top: progressBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: mainViewHeight * 0.7)
        
        view.addSubview(infoContainerView)
        
        infoContainerView.anchor(top: itemsTableView.bottomAnchor, leading: itemsTableView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: itemsTableView.trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 0)
    
        
    }
    
    func didTapOnCreateNewItem() {
        
        let addAlertController = UIAlertController(title: "New Item", message: "Enter a title:", preferredStyle: .alert)
        addAlertController.addTextField { (tf) in
            tf.placeholder = "Title of To Do Item"
        }
        
        let addAction = UIAlertAction(title: "Create", style: .default) { [weak self] (action) in
            
            guard let title = addAlertController.textFields?.first?.text else { return }
            
            let newToDoItem = ToDoItem(title: title, completed: false, createdAt: Date(), itemIdentifier: UUID(), reminderDate: Date().addingTimeInterval(5))

            newToDoItem.saveItem()
            
            self?.toDoListItems.append(newToDoItem)
//
//            LocalNotificationManager.createLocalNotification(forItem: newToDoItem)
            
            let newItemIndexPath = IndexPath(row: (self?.itemsTableView.numberOfRows(inSection: 0))!, section: 0)
            self?.itemsTableView.insertRows(at: [newItemIndexPath], with: .automatic)
            
            
        }
        
        addAlertController.addAction(addAction)
        addAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(addAlertController, animated: true, completion: nil)
        
    }
    
    func loadData() {
        
        toDoListItems = [ToDoItem]()
        
        toDoListItems = FileStorageManager.loadAll(ToDoItem.self).sorted(by: {
            $0.createdAt < $1.createdAt
        })
        
        itemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.cellId, for: indexPath) as! ToDoListCell
        
        let toDoItem = toDoListItems[indexPath.row]
        cell.delegate = self
        cell.viewModel = ToDoItemViewModelFromItem(withItem: toDoItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let setReminderAction = UIContextualAction(style: .normal, title: "Set Reminder") { [weak self] (_, _, handler) in
            handler(true)
            
            if let selectedItem = self?.toDoListItems[indexPath.row] {
                self?.showReminderSetterDisplay(forItem: selectedItem)
            }
        }
        setReminderAction.backgroundColor = UIColor.lightBlue
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [setReminderAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    var reminderSettingsManager: ReminderSettingsManager?
    
    private func showReminderSetterDisplay(forItem item: ToDoItem) {
        self.reminderSettingsManager = ReminderSettingsManager(itemForReminding: item)
        reminderSettingsManager!.showSettings()
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, handler) in
            self?.deleteToDoItem(for: indexPath)
            handler(true)
        }
        
        deleteAction.backgroundColor = UIColor.brightYellow
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteToDoItem(for indexPath: IndexPath) {
        toDoListItems[indexPath.row].deleteItem()
        toDoListItems.remove(at: indexPath.row)
        itemsTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func didCompleteToDoItem(_ cell: ToDoListCell) {
        if let indexPath = itemsTableView.indexPath(for: cell) {
            var toDoItem = toDoListItems[indexPath.row]
            toDoItem.markAsCompleted()
            toDoListItems[indexPath.row] = toDoItem
            
            cell.itemNameLabel.attributedText = cell.itemNameLabel.text?.strikeThroughText()
            
            UIView.animate(withDuration: 0.1, animations: {
                
                cell.transform = cell.transform.scaledBy(x: 1.5, y: 1.5)
                
            }, completion: { (success) in
                
                if success {
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        
                        cell.transform = CGAffineTransform.identity
                        
                    }, completion: nil)
                }
                
            })
        }
    }
    
    func didUncompleteToDoItem(_ cell: ToDoListCell) {
        if let indexPath = itemsTableView.indexPath(for: cell) {
            var toDoItem = toDoListItems[indexPath.row]
            toDoItem.markAsUncompleted()
            toDoListItems[indexPath.row] = toDoItem
            cell.itemNameLabel.attributedText = NSAttributedString(string: toDoItem.title)
        }
    }
}
