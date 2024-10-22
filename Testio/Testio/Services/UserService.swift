//
//  UserService.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import Foundation
import Combine

extension URLs {
    struct Users {
        static var token: String {
            return base + "/tokens"
        }
    }
}

protocol UserServiceProtocol {
    func getToken(user: User) async throws -> Authorization
}

class UserService: UserServiceProtocol {

    func getToken(user: User) async throws -> Authorization {
        guard let url = URLs.Users.token.url else { throw NetworkManager.NetworkError.badUrl }
        do {
            let responseData = try await NetworkManager.post(url: url, 
                                                             body: user,
                                                             responseModel: Authorization.self)
            return responseData
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
