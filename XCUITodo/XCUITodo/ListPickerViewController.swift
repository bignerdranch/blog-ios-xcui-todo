//
//  ListPickerViewController.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ListPickerViewController: UITableViewController {

    var detailViewController: TodoListViewController? = nil
    var todos = Todo.defaultList()

    let filters: [Todo -> Bool] = [
        filteringTodo({ dayOf($0.due) == dayOf(NSDate()) }),
        filteringTodo({ !$0.finished }),
        filteringTodo({ $0.finished })
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers.last as! UINavigationController).topViewController as? TodoListViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let filter = filters[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! TodoListViewController
                controller.todos = todos.filter(filter)

                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}

/// Type-specialized identity function to save from typing inferrable boilerplate.
private func filteringTodo(fn: Todo -> Bool) -> Todo -> Bool { return fn }
private func dayOf(date: NSDate) -> Int {
    return NSCalendar.currentCalendar().component(.Day, fromDate: date)
}
