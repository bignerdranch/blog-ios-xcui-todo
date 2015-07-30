//
//  XCUITodoUITests.swift
//  XCUITodoUITests
//
//  Created by Jeremy on 2015-07-23.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import XCTest

class XCUITodoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCUIApplication().tables.staticTexts["Due Today"].tap()

        /* For a bit, both the old and the new table will be found.
         * This leads to us finding 5 (3 + 2) rather than just 2 cells. */
        _ = self.expectationForPredicate(
            NSPredicate(format: "self.count = 1"),
            evaluatedWithObject: XCUIApplication().tables,
            handler: nil)
        self.waitForExpectationsWithTimeout(5.0, handler: nil)

        let cells = XCUIApplication().tables.cells
        XCTAssertEqual(cells.count, 2, "found instead: \(cells.debugDescription)")

        let first = cells.elementBoundByIndex(0)
        print("first, before: \(first.debugDescription)")
        first.bnr_longPress()

        /* TODO: how do we check if it's finished?! */
        print("first, after: \(first.debugDescription)")
    }

}

extension XCUIElement {
    func bnr_longPress() {
        let duration: NSTimeInterval = 0.5
        pressForDuration(duration)
    }
}
