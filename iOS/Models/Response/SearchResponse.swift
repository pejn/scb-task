//
//  SearchResponse.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import Foundation

struct SearchResponse<AnyDecodable: Decodable>: Decodable {
    let results: [AnyDecodable]
    let totalResults: String
    
    private enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
    }
}
