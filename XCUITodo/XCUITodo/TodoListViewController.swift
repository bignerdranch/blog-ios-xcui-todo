//
//  TodoListViewController.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    private var todos: [Todo] = []
    private var filter: (Todo -> Bool)!
    private var filteredTodos: [Todo] {
        return todos.filter(filter)
    }

    func configure(todos todos: [Todo], filter: Todo -> Bool) {
        self.todos = todos
        self.filter = filter
        print("\(self.title): configured with \(filteredTodos.count) todos")
    }

    var empty: Bool {
        return todos.count == 0
    }

    func todoForIndexPath(indexPath: NSIndexPath) -> Todo {
        let todo = filteredTodos[indexPath.row]
        return todo
    }

    override func tableView(tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return filteredTodos.count
    }

    override func tableView(tableView: UITableView,
            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let todo = todoForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("todo", forIndexPath: indexPath)
            as! TodoCellView
        cell.configure(todo: todo, table: tableView)
        return cell
    }
}
