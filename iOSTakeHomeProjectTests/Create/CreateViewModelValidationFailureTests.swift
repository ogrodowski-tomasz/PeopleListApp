//
//  CreateViewModelValidationFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelValidationFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validationMock: CreateValidationImpl!
    private var vm: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorFailureMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        vm = nil
    }

    func test_with_invalid_form_submission_state_is_invalid() async {
        XCTAssertNil(vm.state, "The view model state should be nil initially")
        defer {
            XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be 'unsuccessful'")
        }
        await vm.create()
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "Error property in the view model shouldn't be nil")
        XCTAssertEqual(vm.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName), "The view model error should be invalid first name")
    }
}
