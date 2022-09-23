//
//  CreateFormValidatorTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 22/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator!
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }
    
    func test_with_empty_person_first_name_error_thrown() {
        let person = NewPerson()
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown() {
        let person = NewPerson(firstName: "", lastName: "lastName", job: "job")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
        
    }
    
    func test_with_empty_last_name_error_thrown() {
        let person = NewPerson(firstName: "firstName", lastName: "", job: "job")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty last name should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Expecting an error where we have an invalid last name")
        }
    }
    
    func test_with_empty_job_error_thrown() {
        let person = NewPerson(firstName: "firstName", lastName: "lastName", job: "")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty job should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Expecting an error where we have an invalid job")
        }
    }
    
    func test_with_valid_person_error_not_thrown() {
        let person = NewPerson(firstName: "firstName", lastName: "lastName", job: "job")
        
        XCTAssertNoThrow(try validator.validate(person), "No error should be thrown, since the person should be a valid object.")
    }
    
}
