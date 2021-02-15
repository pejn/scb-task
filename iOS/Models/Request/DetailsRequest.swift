//
//  DetailsRequest.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

import Foundation

struct DetailsRequest: Encodable {
    let id: String
    let apiKey: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "i", apiKey = "apikey"
    }
}
