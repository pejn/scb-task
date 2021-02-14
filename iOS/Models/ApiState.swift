//
//  ApiState.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 13/02/2021.
//

import Foundation

enum ApiState<T: Decodable, E: Error> {
    case `init`
    case loading
    case success(T)
    case failure(E)
}
