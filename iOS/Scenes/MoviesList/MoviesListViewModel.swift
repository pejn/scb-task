//
//  MoviesListViewModel.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

protocol MoviesListViewModelType {
    init(apiService: ApiServiceType)
}

final class MoviesListViewModel: MoviesListViewModelType {
    private let apiService: ApiServiceType
    
    init(apiService: ApiServiceType) {
        self.apiService = apiService
    }
}
