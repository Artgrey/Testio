//
//  MockServerService_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class MockServerService_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MockServerService_getServers_doesReturnValues() {
        // Given
        let serverService = ServerService()

        // When
        AppManager.token = "f9731b590611a5a9377fbd02f247fcdf"
        let expectation = XCTestExpectation()

        Task {
            do {
                let data = try await serverService.getServers()
                XCTAssertFalse(data.isEmpty)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        // Then
        wait(for: [expectation], timeout: 5)
    }

    func test_MockServerService_getServers_doesFail() {
        // Given
        let serverService = ServerService()

        // When
        AppManager.token = nil
        let expectation1 = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an authorization error")

        Task {
            do {
                _ = try await serverService.getServers()
                XCTFail()
            } catch {
                expectation1.fulfill()

                if error as? NetworkManager.NetworkError == NetworkManager.NetworkError.unauthorized {
                    expectation2.fulfill()
                }
            }
        }
        // Then
        wait(for: [expectation1, expectation2], timeout: 5)
    }

}
