//
//  ApiServiceStub.swift
//  scb-recruitment-taskTests
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

@testable import scb_recruitment_task
import Foundation

final class ApiServiceStub: ApiServiceType {
    static let errorId = "error"
    static let errorSearchTerm = "error"
    
    func searchMovies(_ searchTerm: String, page: Int, completion: @escaping (Result<SearchResponse<Movie>, SCBError>) -> Void) {
        if searchTerm == Self.errorSearchTerm {
            completion(.failure(SCBError.apiError("Error")))
        } else {
            let movies = [Movie(id: "1", title: "title1", poster: "url"),
                          Movie(id: "2", title: "title2", poster: "url"),
                          Movie(id: "3", title: "title3", poster: "url")]
            completion(.success(SearchResponse<Movie>(results: movies, totalResults: "14")))
        }
    }
    
    func loadDetails(id: String, completion: @escaping (Result<MovieDetails, SCBError>) -> Void) {
        if id == Self.errorId {
            completion(.failure(SCBError.apiError("Error")))
        } else {
            let details = MovieDetails(title: "test", year: "123", poster: "", imdbRating: "3.3", imdbVotes: "3434",
                                       runtime: "122min", genre: "comedy", plot: "Lorem ipsum", director: "George Lucas",
                                       actors: "The best", writer: "Who knows?")
            completion(.success(details))
        }
    }
}
