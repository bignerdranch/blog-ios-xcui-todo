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
    var afterToggling: (() -> Void)?

    func configure(todo todo: Todo, afterToggling: () -> ()) {
        self.todo = todo
        self.afterToggling = afterToggling

        textLabel!.attributedText = (todo.finished ? strikethrough : normal)(todo.title)
        detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(
            todo.due, dateStyle: .FullStyle, timeStyle: .ShortStyle)
    }

    @IBAction
    func toggleAction(sender: UIGestureRecognizer) {
        /* State might also be .Ended, but we want to trigger
         * when a press goes on for a while, rather than
         * when the long-pressed touch ends. */
        guard
            let todo = todo
        where
            sender.state == .Began else { return }

        todo.toggleFinished()
        afterToggling?()
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
