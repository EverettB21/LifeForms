//
//  ResultsModals.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import Foundation

struct LifeFormResults: Codable {
    let results: [LifeForm]
}

struct LifeFormDetailResult: Codable {
    let taxonConcept: LifeFormDetail
}

struct AncestorResult: Codable {
    let ancestors: [Ancestor]
}
