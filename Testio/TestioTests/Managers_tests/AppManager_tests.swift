//
//  AppManager_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class AppManager_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AppManager_setToken_tokenShouldBeSet() {
        // Given
        AppManager.token = nil
        XCTAssertEqual(AppManager.token, nil)
        // When
        AppManager.setToken("tokenset")
        // Then
        XCTAssertEqual(AppManager.token, "tokenset")
        let token = try? KeychainManager.read(key: KeychainKey.token)
        XCTAssertEqual(token, "tokenset")
    }

    func test_AppManager_deleteToken_tokenShouldBeDeleted() {
        // Given
        AppManager.token = "tokenset"
        XCTAssertEqual(AppManager.token, "tokenset")
        // When
        AppManager.deleteToken()
        // Then
        XCTAssertEqual(AppManager.token, nil)
        let token = try? KeychainManager.read(key: KeychainKey.token)
        XCTAssertNil(token)
    }

    func test_AppManager_isAuthenticated_isTrueAsKeyChainIsSet() {
        // Given
        XCTAssertFalse(AppManager.IsAuthenticated)
        // When
        AppManager.setToken("tokenset")
        // Then
        XCTAssertTrue(AppManager.IsAuthenticated)
    }

    func test_AppManager_isAuthenticated_isFalseAsKeyChainIsRemoved() {
        // Given
        AppManager.setToken("tokenset")
        XCTAssertTrue(AppManager.IsAuthenticated)
        // When
        AppManager.deleteToken()
        // Then
        XCTAssertFalse(AppManager.IsAuthenticated)
    }
}
