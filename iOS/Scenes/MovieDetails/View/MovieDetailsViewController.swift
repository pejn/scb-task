//
//  MovieDetailsViewController.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let viewModel: MovieDetailsViewModelType
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .red
        indicator.backgroundColor = .systemBackground
        return indicator
    }()
    private lazy var detailsView: MovieDetailsView = MovieDetailsView()
    
    init(viewModel: MovieDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(detailsView)
        detailsView.edgesToSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.result.bind { [weak self] result in
            guard let self = self else {
                return
            }
            self.stopLoading()
            switch result {
            case nil:
                break
            case .loading:
                self.startLoading()
            case .success(let result):
                self.detailsView.update(with: result)
            case .failure:
                break //TODO: Handle error
            }
        }
        viewModel.loadDetails()
    }
    
    private func startLoading() {
        guard loadingIndicator.superview == nil else {
            return
        }
        view.addSubview(loadingIndicator)
        loadingIndicator.edgesToSuperview()
        loadingIndicator.startAnimating()
    }
    
    private func stopLoading() {
        guard loadingIndicator.superview != nil else {
            return
        }
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
