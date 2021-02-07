//
//  MovieDetails.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

struct MovieDetails {
    let title: String
    let year: String
    let poster: String
    let imdbRating: String
    let imdbVotes: String
    let runtime: String
    let genre: String
    let plot: String
    let director: String
    let actors: String
    let writer: String
}

extension MovieDetails: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbRating, imdbVotes
        case runtime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case director = "Director"
        case actors = "Actors"
        case writer = "Writer"
    }
}
