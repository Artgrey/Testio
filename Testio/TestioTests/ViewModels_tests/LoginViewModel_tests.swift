//
//  LoginViewModel_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class LoginViewModel_tests: XCTestCase {

    var viewModel: LoginViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = LoginViewModel(userService: UserService())
        AppManager.token = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        AppManager.token = nil
    }

    func test_LoginViewModel_loginUser_shouldLogin() async {
        // Given
        viewModel?.loginContainerViewModel.username = "tesonet"
        viewModel?.loginContainerViewModel.password = "partyanimal"
        // When
        let expectation = XCTestExpectation(description: "Data is fetched successfully.")
        viewModel?.loginContainerViewModel.action?()
        // Then
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        XCTAssertNotNil(AppManager.token)
        XCTAssertEqual(viewModel?.showAlert, false)

        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func test_LoginViewModel_loginUser_shouldFail() async {
        // Given
        viewModel?.loginContainerViewModel.username = "tesonet"
        viewModel?.loginContainerViewModel.password = "party"
        // When
        let expectation = XCTestExpectation(description: "Data isn't fetched")
        viewModel?.loginContainerViewModel.action?()
        // Then
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        XCTAssertNil(AppManager.token)
        XCTAssertEqual(viewModel?.showAlert, true)

        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
