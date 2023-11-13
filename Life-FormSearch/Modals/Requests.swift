//
//  Requests.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import Foundation

protocol APIrequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

struct LifeFormRequest: APIrequest {
    
    var queryItems: [String: String]
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: "https://eol.org/api/search/1.0.json")!
        components.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return URLRequest(url: components.url!)
    }
    
    func decodeResponse(data: Data) throws -> [LifeForm] {
        let response = try! JSONDecoder().decode(LifeFormResults.self, from: data)
        return response.results
    }
}

struct LifeFormDetailRequest: APIrequest {
    var queryItems: [String: String]
    var itemID: Int
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: "https://eol.org/api/pages/1.0/\(itemID).json?")
        components?.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return URLRequest(url: components!.url!)
    }
    
    func decodeResponse(data: Data) throws -> LifeFormDetail? {
        let response = try! JSONDecoder().decode(LifeFormDetailResult.self, from: data)
        return response.taxonConcept
    }
}

struct AncestorRequest: APIrequest {
    var itemID: Int
    var queryItems: [String: String]
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: "https://eol.org/api/hierarchy_entries/1.0/\(itemID).json?")!
        components.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return URLRequest(url: components.url!)
    }
    
    func decodeResponse(data: Data) throws -> [Ancestor] {
        let response = try! JSONDecoder().decode(AncestorResult.self, from: data)
        return response.ancestors
    }
}
