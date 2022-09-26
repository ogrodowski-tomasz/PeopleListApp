//
//  CreateFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Tomasz Ogrodowski on 26/09/2022.
//

import XCTest

final class CreateFailureUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        // if test fails we wan to STOP
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success":"1",
            "-create-networking-success":"0"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_shown_when_submission_fails() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There should be create button visible on the screen")
        
        createBtn.tap()
        
        let firstNameTextField = app.textFields["firstNameTxtField"]
        let lastNameTextField = app.textFields["lastNameTxtField"]
        let jobTextField = app.textFields["jobTxtField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("MyFirstName")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("MyLastName")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.exists, "There should be submit button visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert shown")
        
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
    }
    
}
