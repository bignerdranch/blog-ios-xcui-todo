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

    func configure(todos todos: [Todo], filter: Todo -> Bool) {
        self.todos = todos
        self.filter = filter
        print("\(self.title): configured with \(todos.filter(filter).count) todos")
    }

    var empty: Bool {
        return todos.count == 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

