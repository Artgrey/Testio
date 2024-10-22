//
//  KeychainManager_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class KeychainManager_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? KeychainManager.delete(key: "password")
        try? KeychainManager.delete(key: "data")
        try? KeychainManager.delete(key: "temp_key")
    }

    func test_KeychainManager_saveToKeychain() {
        // Given
        try? KeychainManager.save(key: "password", value: "1234")
        // When
        let retrievedValue = try? KeychainManager.read(key: "password")
        // Tren
        XCTAssertEqual(retrievedValue, "1234")
    }

    func test_KeychainManager_readFromKeychain() {
        // Given
        try? KeychainManager.save(key: "data", value: "keychain")
        // When
        let retrievedValue = try? KeychainManager.read(key: "data")
        // Tren
        XCTAssertEqual(retrievedValue, "keychain")
    }

    func test_KeychainManager_deleteFromKeychain() {
        // Given
        try? KeychainManager.save(key: "temp_key", value: "text")
        // When
        try? KeychainManager.delete(key: "temp_key")
        let value = try? KeychainManager.read(key: "temp_key")
        // then
        XCTAssertNil(value)
    }
}
