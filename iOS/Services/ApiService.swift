//
//  ApiService.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Alamofire

protocol ApiServiceType {
    func searchMovies(_ searchTerm: String, page: Int, completion: @escaping (Result<SearchResponse<Movie>, SCBError>) -> Void)
}

final class ApiService: ApiServiceType {
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    func searchMovies(_ title: String, page: Int, completion: @escaping (Result<SearchResponse<Movie>, SCBError>) -> Void) {
        let request = SearchRequest(title: title, apiKey: Constants.apiKey,
                                    type: .movie, page: page)
        session.request(Constants.baseURL, method: .get, parameters: request,
                        encoder: URLEncodedFormParameterEncoder(destination: .queryString))
            .validate()
            .responseDecodable { (response: DataResponse<SearchResponse<Movie>, AFError>) in
                let result = response.result.mapError { error in
                    return SCBError(from: response.data)
                }
                completion(result)
            }
    }
}
