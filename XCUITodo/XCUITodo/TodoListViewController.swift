//
//  TodoListViewController.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    fileprivate var todos: [Todo] = []
    fileprivate var filter: ((Todo) -> Bool)!
    fileprivate var filteredTodos: [Todo] {
        return todos.filter(filter)
    }

    func configure(todos: [Todo], filter: @escaping (Todo) -> Bool) {
        self.todos = todos
        self.filter = filter
        print("\(self.title): configured with \(filteredTodos.count) todos")
    }

    var empty: Bool {
        return todos.count == 0
    }

    func todoForIndexPath(_ indexPath: IndexPath) -> Todo {
        let todo = filteredTodos[(indexPath as NSIndexPath).row]
        return todo
    }

    override func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return filteredTodos.count
    }

    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
            as! TodoCellView
        cell.configure(todo: todo) {
            [weak cell, weak tableView] in
            tableView?.bnr_reloadRowForCell(cell, withRowAnimation: .fade)
        }
        return cell
    }
}

extension UITableView {
    func bnr_reloadRowForCell(_ cell: UITableViewCell?,
            withRowAnimation animation: UITableViewRowAnimation) {
        guard
            let cell = cell,
            let indexPath = indexPath(for: cell) else { return }
        reloadRows(at: [indexPath], with: animation)
    }
}
