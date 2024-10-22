//
//  NetworkManager_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class NetworkManager_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NetworkManager_getRequest_dataShouldBeReturned() async {
        // Given
        guard let url =  URLs.Server.info.url else {
            XCTFail()
            return
        }
        AppManager.token = "f9731b590611a5a9377fbd02f247fcdf"
        let expectation = XCTestExpectation()
        // When
        do {
            let responseData = try await NetworkManager.get(url: url, responseModel: [Server].self)
            XCTAssertFalse(responseData.isEmpty)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func test_NetworkManager_getRequest_dataReturnedFail() async {
        // Given
        guard let url =  URLs.Server.info.url else {
            XCTFail()
            return
        }
        AppManager.token = nil
        let expectation = XCTestExpectation()
        // When
        do {
            _ = try await NetworkManager.get(url: url, responseModel: [Server].self)
            XCTFail()
        } catch {
            expectation.fulfill()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func test_NetworkManager_postRequest_dataShouldBeReturned() async {
        // Given
        guard let url =  URLs.Users.token.url else {
            XCTFail()
            return
        }
        let user = User(username: "tesonet", 
                        password: "partyanimal")
        let expectation = XCTestExpectation()
        // When
        do {
            let responseData = try await NetworkManager.post(url: url,body: user, responseModel: Authorization.self)
            XCTAssertFalse(responseData.token.isEmpty)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func test_NetworkManager_postRequest_dataReturnedFail() async {
        // Given
        guard let url =  URLs.Users.token.url else {
            XCTFail()
            return
        }
        let user = User(username: "teso",
                        password: "partyanimal")
        let expectation = XCTestExpectation()
        // When
        do {
            _ = try await NetworkManager.post(url: url, body: user, responseModel: Authorization.self)
            XCTFail()
        } catch {
            expectation.fulfill()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
