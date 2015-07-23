//
//  TodoListViewController.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var todos: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

