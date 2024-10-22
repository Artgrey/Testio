//
//  URLRequest+RequestBuilder.swift
//  Testio
//
//  Created by Arturas Krivenkis on 17/10/2024.
//

import Foundation

extension URLRequest {

    func setHeaders() -> URLRequest {
        var request = self
        if let token = AppManager.token {
            request = request.token(token)
        }
        return request.contentType(.json)
    }

    func method(_ method: HTTPMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }

    func body(json body: Encodable?) -> URLRequest {
        var request = self
        guard let body = body else { return request }
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }

    func contentType(_ contentType: ContentType) -> URLRequest {
        return setValue(contentType.rawValue, forHeader: "Content-Type")
    }

    func token(_ token: String) -> URLRequest {
        return setValue(token, forHeader: "Authorization")
    }

    func setValue(_ value: String, forHeader header: String) -> URLRequest {
        var request = self
        request.setValue(value, forHTTPHeaderField: header)
        return request
    }
}
