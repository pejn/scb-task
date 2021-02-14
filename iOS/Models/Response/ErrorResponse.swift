//
//  ErrorResponse.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

import Foundation

struct ErrorResponse: Decodable {
    let error: String
    
    private enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}
