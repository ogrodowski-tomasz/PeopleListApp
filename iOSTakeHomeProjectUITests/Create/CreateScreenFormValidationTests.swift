//
//  CreateScreenFormValidationTests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Tomasz Ogrodowski on 26/09/2022.
//

import XCTest

final class CreateScreenFormValidationTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        // if test fails we wan to STOP
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_when_all_form_fields_is_empty_first_name_error_is_shown() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There should be create button visible on the screen")
        
        createBtn.tap()
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "There should be submit button visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        let alertBtn = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be alert on teh screen")
        XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(alertBtn.label, "OK")
        
        alertBtn.tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
    
    func test_when_first_name_form_field_is_empty_first_name_error_is_shown() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There should be create button visible on the screen")
        
        createBtn.tap()
        
        let lastNameTextField = app.textFields["lastNameTxtField"]
        let jobTextField = app.textFields["jobTxtField"]
        
        lastNameTextField.tap()
        lastNameTextField.typeText("MyLastName")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "There should be submit button visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        let alertBtn = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be alert on teh screen")
        XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(alertBtn.label, "OK")
        
        alertBtn.tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }
    
    func test_when_last_name_form_field_is_empty_last_name_error_is_shown() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There should be create button visible on the screen")
        
        createBtn.tap()
        
        let firstNameTextField = app.textFields["firstNameTxtField"]
        let jobTextField = app.textFields["jobTxtField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("MyFirstName")
        
        jobTextField.tap()
        jobTextField.typeText("iOS Developer")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "There should be submit button visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        let alertBtn = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be alert on teh screen")
        XCTAssertTrue(alert.staticTexts["Last name can't be empty"].exists)
        XCTAssertEqual(alertBtn.label, "OK")
        
        alertBtn.tap()
        
        XCTAssertTrue(app.staticTexts["Last name can't be empty"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }

    func test_when_job_form_field_is_empty_job_error_is_shown() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There should be create button visible on the screen")
        
        createBtn.tap()
        
        let firstNameTextField = app.textFields["firstNameTxtField"]
        let lastNameTextField = app.textFields["lastNameTxtField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("MyFirstName")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("MyLastName")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "There should be submit button visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        let alertBtn = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be alert on teh screen")
        XCTAssertTrue(alert.staticTexts["Job can't be empty"].exists)
        XCTAssertEqual(alertBtn.label, "OK")
        
        alertBtn.tap()
        
        XCTAssertTrue(app.staticTexts["Job can't be empty"].exists)
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
    }

}
