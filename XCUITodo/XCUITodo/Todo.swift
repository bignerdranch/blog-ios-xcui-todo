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
    var finished: Bool

    func toggleFinished() {
        finished = !finished
    }

    init(title: String, due: NSDate, finished: Bool) {
        self.title = title
        self.due = due
        self.finished = finished
    }

    static func defaultList() -> [Todo] {
        let titles = "Do something,Do anything,Do be do be do,Stuff and things,Like y'know?".componentsSeparatedByString(",")

        let Day: NSTimeInterval = 60 /*s/m*/ * 60 /*m/h*/ * 24 /*h/day => s/day*/
        let now = NSDate()
        let delta = 10*Day
        let dates = [now
            , now.dateByAddingTimeInterval(-delta)
            , now.dateByAddingTimeInterval(+delta)]

        let finishEveryNth = 5

        let defaults = titles.enumerate().map {
            Todo(title: $1, due: dates[$0 % dates.count], finished: $0 % finishEveryNth == 0)
        }
        return defaults
    }
}
