//
//  ServerService.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import Foundation
import Combine

extension URLs {
    struct Server {
        static var info: String {
            return base + "/servers"
        }
    }
}

protocol ServerServiceProtocol {
    func getServers() async throws -> [Server]
}

class ServerService: ServerServiceProtocol {

    func getServers() async throws -> [Server] {
        guard let url = URLs.Server.info.url else { throw NetworkManager.NetworkError.badUrl }

        do {
            let response = try await NetworkManager.get(url: url, 
                                                        responseModel: [Server].self)
            return response
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
