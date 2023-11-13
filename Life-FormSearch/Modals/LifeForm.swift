//
//  LifeForm.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import Foundation

struct LifeForm: Codable {
    var id: Int
    var title: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
    }
}
