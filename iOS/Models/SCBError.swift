//
//  SCBError.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 13/02/2021.
//

import Foundation

enum SCBError: Error {
    case unknown
    case apiError(String)
    
    init(from responseData: Data?) {
        guard let data = responseData,
              let model = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
            self = .unknown
            return
        }
        self = .apiError(model.error)
    }
    
    var localizedDescription: String {
        switch self {
        case .apiError(let message):
            return message
        case .unknown:
            return "Unhandled error"
        }
    }
}
