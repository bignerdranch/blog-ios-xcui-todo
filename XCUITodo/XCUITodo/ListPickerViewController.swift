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

    let filters: [(Todo) -> Bool] = [
        filteringTodo({ dayOf($0.due as Date) == dayOf(Date()) }),
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

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier.hasPrefix(SegueShowDetail) {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let filter = filters[(indexPath as NSIndexPath).row]
                let controller = (segue.destination as! UINavigationController).topViewController as! TodoListViewController
                controller.title = self.tableView.cellForRow(at: indexPath)?.textLabel?.text

                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true

                controller.configure(todos: todos, filter: filter)
            }
        }
    }

}

private let SegueShowDetail = "showDetail"

/// Type-specialized identity function to save from typing inferrable boilerplate.
private func filteringTodo(_ fn: @escaping (Todo) -> Bool) -> (Todo) -> Bool { return fn }
private func dayOf(_ date: Date) -> Int {
    return (Calendar.current as NSCalendar).component(.day, from: date)
}
