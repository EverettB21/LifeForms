//
//  LifeFormDetail.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/13/23.
//

import Foundation

struct LifeFormDetail: Codable {
    var identifier: Int
    var scientificName: String
    var taxonConcepts: [taxonConcept]?
    var dataObjects: [dataObject]?
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case scientificName
        case taxonConcepts
        case dataObjects
    }
}

struct taxonConcept: Codable {
    var identifier: Int
    var scientificName: String
    var name: String
    var nameAccordingTo: String
    var canonicalForm: String
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case scientificName
        case name
        case nameAccordingTo
        case canonicalForm
    }
}

struct dataObject: Codable {
    var identifier: String
    var mediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case mediaURL
    }
}
