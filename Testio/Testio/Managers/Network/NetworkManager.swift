//
//  NetworkManager.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import Foundation
import Combine

struct NetworkManager {

    enum NetworkError: LocalizedError, Equatable {
        case badUrlResponse(url: URL)
        case unauthorized
        case badUrl
        case unknown

        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url):
                return "Bad URL Response \(url)"
            case .unauthorized:
                return "Unauthorized user"
            case .badUrl:
                return "Bad URL"
            case .unknown:
                return "Unknown"
            }
        }
    }

    static func get<T: Decodable>(url: URL, responseModel: T.Type) async throws -> T {
        let request = buildURLRequest(url: url, httpMethod: .get)

        let (data, response) = try await URLSession.shared.data(for: request)

        return try handleResponse(data: data, response: response, url: url)
    }

    static func post<T: Decodable, U: Encodable>(url: URL, body: U, responseModel: T.Type) async throws -> T {
        let request = buildURLRequest(url: url, httpMethod: .post, body: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        return try handleResponse(data: data, response: response, url: url)
    }

    private static func buildURLRequest(url: URL, httpMethod: HTTPMethod, body: Encodable? = nil) -> URLRequest {
        return URLRequest(url: url)
            .method(httpMethod)
            .setHeaders()
            .body(json: body)
    }

    private static func handleResponse<T: Decodable>(data: Data, response: URLResponse, url: URL) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badUrlResponse(url: url)
        }
        switch response.statusCode {
        case 200...299:
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.badUrlResponse(url: url)
        }
    }
}
