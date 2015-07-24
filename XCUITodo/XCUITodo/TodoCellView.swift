//
//  TodoCellView.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-24.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TodoCellView : UITableViewCell {
    weak var todo: Todo?
    weak var table: UITableView?

    func configure(todo todo: Todo, table: UITableView) {
        self.todo = todo
        self.table = table

        textLabel!.attributedText = (todo.finished ? strikethrough : normal)(todo.title)
        detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(
            todo.due, dateStyle: .FullStyle, timeStyle: .ShortStyle)
    }

    func toggleFinished() {
        guard
            let todo = todo,
            let table = table,
            let indexPath = table.indexPathForCell(self) else { return }

        todo.toggleFinished()
        table.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    @IBAction
    func toggleAction(sender: UIGestureRecognizer) {
        /* State might also be .Ended, but we want to trigger
         * when a press goes on for a while, rather than
         * when the long-pressed touch ends. */
        guard sender.state == .Began else { return }

        toggleFinished()
    }

    func addToggleRecognizer() {
        let recognizer = UILongPressGestureRecognizer()
        self.addGestureRecognizer(recognizer)
        recognizer.addTarget(self, action: "toggleAction:")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToggleRecognizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addToggleRecognizer()
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
