//
//  MovieDetailsViewModel.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

protocol MovieDetailsViewModelType {
    var result: Bindable<ApiState<MovieDetails, SCBError>> { get }
    func loadDetails()
}

final class MovieDetailsViewModel: MovieDetailsViewModelType {
    let result: Bindable<ApiState<MovieDetails, SCBError>> = .init()
    
    private let movieId: String
    private let apiService: ApiServiceType
    
    init(movieId: String, apiService: ApiServiceType) {
        self.movieId = movieId
        self.apiService = apiService
    }
    
    func loadDetails() {
        result.value = .loading
        apiService.loadDetails(id: movieId) { [weak self] result in
            switch result {
            case .success(let model):
                self?.result.value = .success(model)
            case .failure(let error):
                self?.result.value = .failure(error)
            }
        }
    }
}
