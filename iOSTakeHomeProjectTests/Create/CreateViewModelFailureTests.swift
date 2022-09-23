//
//  CreateViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelFailureTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var validationMock: CreateValidationImpl!
    private var vm: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateFailureMock()
        validationMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_submission_state_is_unsuccessful() async throws {
        XCTAssertNil(vm.state, "The view model state should be nil")
        defer { XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be unsuccessful") }
        await vm.create()
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model should have an error")
        XCTAssertEqual(vm.error, .networking(error: NetworkingManager.NetworkingError.invalidURL), "The view model error should be a networking error with an invalid url")
    }
    
}
