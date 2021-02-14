//
//  SearchRequest.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import Foundation

struct SearchRequest: Encodable {
    enum SearchType: String, Encodable {
        case movie
    }
    let title: String
    let apiKey: String
    let type: SearchType
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case title = "s", apiKey = "apikey", type, page
    }
}
