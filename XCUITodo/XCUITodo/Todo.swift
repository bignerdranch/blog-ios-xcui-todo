//
//  Todo.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

class Todo {
    let title: String
    let due: NSDate
    let finished: Bool

    init(title: String, due: NSDate, finished: Bool) {
        self.title = title
        self.due = due
        self.finished = finished
    }
}
