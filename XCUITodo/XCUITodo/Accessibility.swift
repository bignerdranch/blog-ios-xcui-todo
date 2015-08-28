//
//  Accessibility.swift
//  XCUITodo
//
//  Created by Jeremy on 2015-07-30.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

class Accessibility {
    static func titlePrefixedToIndicateFinished(title: String) -> String {
        /* Genstrings uses first argument verbatim when generating
         * Localizable.strings files,
         * so interpolating a constant prefix here like "\(prefix): %@"
         * would not be terribly useful. */
        let template = NSLocalizedString("done: %@",
            comment: "accessibility label for finished todo item")
        let label = NSString.localizedStringWithFormat(template, title)
        return label as String
    }

    static var FinishedTitlePrefix: String {
        /* Exploit that prefixing the empty string returns just the prefix. */
        return titlePrefixedToIndicateFinished("")
    }
}
