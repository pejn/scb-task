//
//  Movie.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let poster: String
}

extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case poster = "Poster"
    }
}
