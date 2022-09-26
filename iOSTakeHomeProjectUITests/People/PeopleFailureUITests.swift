//
//  PeopleFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import XCTest

final class PeopleFailureUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        // if test fails we wan to STOP
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-people-networking-success":"0"] // simulating no internet connection
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_shown_when_screen_fails_to_loads() {
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be alert on the screen")
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["Retry"].exists)
    }
    
}
