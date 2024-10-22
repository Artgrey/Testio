//
//  KeychainManager.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import Foundation

struct KeychainManager {

    private static let service = Bundle.main.bundleIdentifier

    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }

    static func save(key: String, value: String) throws {
        let value = value.data(using: .utf8)

        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: key as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: value as AnyObject
        ]

        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )

        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }

    static func read(key: String) throws -> String {
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: key as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        guard let value = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }

        return String(decoding: value, as: UTF8.self)
    }

    static func delete(key: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: key as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
