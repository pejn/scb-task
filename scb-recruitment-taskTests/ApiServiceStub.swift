//
//  ApiServiceStub.swift
//  scb-recruitment-taskTests
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

@testable import scb_recruitment_task
import Foundation

final class ApiServiceStub: ApiServiceType {
    func searchMovies(_ searchTerm: String, page: Int, completion: @escaping (Result<SearchResponse<Movie>, SCBError>) -> Void) {
        if searchTerm == "error" {
            completion(.failure(SCBError.apiError("Error")))
        } else {
            let movies = [Movie(id: "1", title: "title1", poster: "url"),
                          Movie(id: "2", title: "title2", poster: "url"),
                          Movie(id: "3", title: "title3", poster: "url")]
            completion(.success(SearchResponse<Movie>(results: movies, totalResults: "14")))
        }
    }
}
