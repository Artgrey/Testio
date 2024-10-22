//
//  MockUserService_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class MockUserService_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MockUserService_getToken_doesReturnValues() {
        // Given
        let userService = UserService()

        // When
        let user: User = User(username: "tesonet", password: "partyanimal")
        let expectation = XCTestExpectation()

        Task {
            do {
                let data = try await userService.getToken(user: user)
                XCTAssertFalse(data.token.isEmpty)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        // Then
        wait(for: [expectation], timeout: 5)
    }

    func test_MockUserService_getToken_doesFail() {
        // Given
        let userService = UserService()

        // When
        let user: User = User(username: "tesonet", password: "party")
        let expectation1 = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an authorization error")

        Task {
            do {
                _ = try await userService.getToken(user: user)
                XCTFail()
            } catch {
                expectation1.fulfill()

                if error as? NetworkManager.NetworkError == NetworkManager.NetworkError.unauthorized {
                    expectation2.fulfill()
                }
            }
        }
        wait(for: [expectation1, expectation2], timeout: 5)
    }
}
