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

    @IBAction
    func longPressAction(sender: UILongPressGestureRecognizer) {
        /* State might also be .Ended, but we want to trigger
         * when a press goes on for a while, rather than
         * when the long-pressed touch ends. */
        guard sender.state == .Began else { return }

        let longPressPoint = sender.locationInView(self.tableView)
        let maybeIndexPath = self.tableView.indexPathForRowAtPoint(longPressPoint)
        guard let indexPath = maybeIndexPath else { return }

        toggleFinished(atIndexPath: indexPath)
    }

    func toggleFinished(atIndexPath indexPath: NSIndexPath) {
        let todo = todoForIndexPath(indexPath)
        todo.toggleFinished()
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
        cell.textLabel!.attributedText = (todo.finished ? strikethrough : normal)(todo.title)
        cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(todo.due, dateStyle: .FullStyle, timeStyle: .ShortStyle)
        return cell
    }
}

private func normal(text: String) -> NSAttributedString {
    return NSAttributedString(string: text)
}

private func strikethrough(text: String) -> NSAttributedString {
    return NSAttributedString(string: text, attributes:
        [NSStrikethroughStyleAttributeName
            : NSUnderlineStyle.StyleSingle.rawValue])
}
