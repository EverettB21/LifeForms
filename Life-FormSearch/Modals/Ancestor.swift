//
//  Ancestor.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/13/23.
//

import Foundation

struct Ancestor: Codable {
    var taxonRank: String?
    var scientificName: String?
    
    enum CodingKeys: String, CodingKey {
        case taxonRank
        case scientificName
    }
}
