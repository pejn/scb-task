//
//  MoviesListViewController.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import UIKit

final class MoviesListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoviesListCell.self, forCellWithReuseIdentifier: MoviesListCell.identifier)
        collectionView.register(LoadingCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        return label
    }()
    private let viewModel: MoviesListViewModelType
    
    init(viewModel: MoviesListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        view.addSubview(errorLabel)
        collectionView.edgesToSuperview()
        errorLabel.edgesToSuperview()
        errorLabel.centerInSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Film list"
        setupSearchBar()
        viewModel.result.bind { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.hideError()
                switch result {
                case .success(let movies):
                    let currentlyDisplayedModelCount = self.viewModel.model.count - movies.count
                    let indexPaths = movies.enumerated().map {
                        IndexPath(item: currentlyDisplayedModelCount + $0.offset, section: 0)
                    }
                    self.collectionView.insertItems(at: indexPaths)
                case .failure(let error):
                    self.showError(error.localizedDescription)
                case .`init`:
                    self.collectionView.reloadData()
                case .loading:
                    break
                }
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    private func setupSearchBar() {
        let controller = UISearchController()
        controller.searchBar.delegate = self
        controller.searchBar.showsCancelButton = false
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Enter a movie title:"
        navigationItem.searchController = controller
    }
    
    private func showError(_ text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    private func hideError() {
        errorLabel.text = nil
        errorLabel.isHidden = true
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return
        }
        viewModel.search(with: searchText)
    }
}

extension MoviesListViewController: MovieDetailsNavigatable {}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let padding: CGFloat = 20
        let spacing: CGFloat = 15
        let availableWidth: CGFloat = collectionView.frame.width - spacing - padding * 2
        let width = availableWidth / numberOfColumns
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if case .loading = viewModel.result.value {
            return CGSize(width: collectionView.frame.width, height: 80)
        }
        return .zero
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingCell.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.model[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCell.identifier, for: indexPath) as? MoviesListCell else {
            fatalError("MoviesListCell init failed")
        }
        cell.configure(title: item.title, imageUrl: URL(string: item.poster))
        return cell
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.model[indexPath.row]
        showDetails(movieId: item.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastCell = indexPath.row == viewModel.model.count - 1
        if isLastCell {
            viewModel.loadMore()
        }
    }
}
