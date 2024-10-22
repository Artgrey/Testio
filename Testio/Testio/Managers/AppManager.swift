//
//  AppManager.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import Foundation
import Combine

struct AppManager {

    static let Authenticated = PassthroughSubject<Bool, Never>()
    static var token: String?

    static var IsAuthenticated: Bool {
        guard let token = try? KeychainManager.read(key: KeychainKey.token) else { return false }
        self.token = token
        return true
    }

    static func deleteToken() {
        token = nil
        Authenticated.send(false)
        do {
            try KeychainManager.delete(key: KeychainKey.token)
        } catch {
            print(error.localizedDescription)
        }
    }

    static func setToken(_ token: String) {
        self.token = token
        Authenticated.send(true)
        do {
            try KeychainManager.save(key: KeychainKey.token, value: token)
        } catch {
            print(error.localizedDescription)
        }
    }
}
