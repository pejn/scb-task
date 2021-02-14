//
//  MoviesListViewModel.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import Foundation

protocol MoviesListViewModelType: class {
    var model: [Movie] { get }
    var result: Bindable<ApiState<[Movie], SCBError>> { get }

    func search(with searchTerm: String)
    func loadMore()
}

final class MoviesListViewModel: MoviesListViewModelType {
    var model: [Movie] {
        return currentState.movies
    }
    let result: Bindable<ApiState<[Movie], SCBError>> = .init(value: .`init`)
    
    private struct State {
        var currentPage = 1
        var totalResults = 0
        var movies: [Movie] = []
        var searchTerm: String
        
        func hasLoadedAll() -> Bool {
            return movies.count >= totalResults
        }
    }
    private var currentState = State(searchTerm: "")
    private let debouncedSearch = Debouncer(delay: 0.5)
    private let apiService: ApiServiceType
    
    init(apiService: ApiServiceType) {
        self.apiService = apiService
    }
    
    func search(with searchTerm: String) {
        currentState = State(searchTerm: searchTerm)
        result.value = .`init`
        debouncedSearch.call { [weak self] in
            self?.requestAPI(searchTerm: searchTerm)
        }
    }
    
    func loadMore() {
        guard !currentState.hasLoadedAll() else {
            return
        }
        requestAPI(searchTerm: currentState.searchTerm)
    }
    
    private func requestAPI(searchTerm: String) {
        if case .loading = result.value {
            return
        }
        result.value = .loading
        apiService.searchMovies(searchTerm, page: currentState.currentPage) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.currentState.currentPage += 1
                self.currentState.totalResults = Int(response.totalResults) ?? 0
                self.currentState.movies += response.results
                self.result.value = .success(response.results)
            case .failure(let error):
                self.result.value = .failure(error)
            }
        }
    }
}
