//
//  MoviesListNavigatable.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import UIKit

protocol MoviesListNavigatable {
    func showMoviesList(animated: Bool)
}

extension MoviesListNavigatable where Self: UINavigationController {
    func showMoviesList(animated: Bool) {
        let viewModel = MoviesListViewModel(apiService: ApiService())
        let controller = MoviesListViewController(viewModel: viewModel)
        pushViewController(controller, animated: animated)
    }
}

extension UINavigationController: MoviesListNavigatable {}
