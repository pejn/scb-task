//
//  MovieDetailsNavigatable.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 07/02/2021.
//

import UIKit

protocol MovieDetailsNavigatable {
    func showDetails(movieId: String)
}

extension MovieDetailsNavigatable where Self: UIViewController {
    func showDetails(movieId: String) {
        let viewModel = MovieDetailsViewModel(movieId: movieId, apiService: ApiService())
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
