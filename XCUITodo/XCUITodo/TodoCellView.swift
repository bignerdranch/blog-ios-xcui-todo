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

    func configure(todo: Todo, afterToggling: @escaping () -> ()) {
        self.todo = todo
        self.afterToggling = afterToggling

        textLabel!.attributedText = (todo.finished ? strikethrough : normal)(todo.title)
        textLabel!.accessibilityLabel = accessibilityLabelFor(todo)
        detailTextLabel!.text = DateFormatter.localizedString(
            from: todo.due as Date, dateStyle: .full, timeStyle: .short)
    }

    fileprivate func accessibilityLabelFor(_ todo: Todo) -> String {
        guard todo.finished else { return todo.title }

        return Accessibility.titlePrefixedToIndicateFinished(todo.title)
    }

    @IBAction
    func toggleAction(_ sender: UIGestureRecognizer) {
        /* State might also be .Ended, but we want to trigger
         * when a press goes on for a while, rather than
         * when the long-pressed touch ends. */
        guard
            let todo = todo
        ,
            sender.state == .began else { return }

        todo.toggleFinished()
        afterToggling?()
    }

    func addToggleRecognizer() {
        let recognizer = UILongPressGestureRecognizer()
        self.addGestureRecognizer(recognizer)
        recognizer.addTarget(self, action: #selector(TodoCellView.toggleAction(_:)))
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

private func normal(_ text: String) -> NSAttributedString {
    return NSAttributedString(string: text)
}

private func strikethrough(_ text: String) -> NSAttributedString {
    return NSAttributedString(string: text, attributes:
        [NSStrikethroughStyleAttributeName
            : NSUnderlineStyle.styleSingle.rawValue])
}
