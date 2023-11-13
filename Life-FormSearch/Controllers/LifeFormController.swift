//
//  LifeFormController.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import Foundation

class LifeFormController {
    
    static var shared = LifeFormController()
    
    enum ApiRequestError: Error, LocalizedError {
        case itemNotFound
    }
    
    func sendRequest<Request: APIrequest>(_ request: Request) async throws -> Request.Response {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw ApiRequestError.itemNotFound
        }
        let decoded = try request.decodeResponse(data: data)
        return decoded
    }
}
