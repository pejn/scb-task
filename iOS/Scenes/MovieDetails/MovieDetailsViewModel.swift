//
//  MovieDetailsViewModel.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

protocol MovieDetailsViewModelType {
    init(movieId: String, apiService: ApiServiceType)
}

final class MovieDetailsViewModel: MovieDetailsViewModelType {
    private let movieId: String
    private let apiService: ApiServiceType
    
    init(movieId: String, apiService: ApiServiceType) {
        self.movieId = movieId
        self.apiService = apiService
    }
}
