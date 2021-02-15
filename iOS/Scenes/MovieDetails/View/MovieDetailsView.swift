//
//  MovieDetailsView.swift
//  scb-recruitment-task
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

import UIKit
import Kingfisher
import TinyConstraints

final class MovieDetailsView: UIView {
    private let scrollView = UIScrollView()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel(numberOfLines: 2, font: .systemFont(ofSize: 18, weight: .medium))
        label.backgroundColor = .systemBackground
        return label
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.backgroundColor = .systemBackground
        return label
    }()
    private let categoriesLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: 14))
    private let durationLabel = UILabel()
    private let ratingLabel = UILabel()
    private let synopsisLabel = UILabel(numberOfLines: 0, font: .italicSystemFont(ofSize: 14))
    private let scoreLabel: UILabel = {
        let label = UILabel(numberOfLines: 0)
        label.textAlignment = .center
        return label
    }()
    private let reviewsLabel: UILabel = {
        let label = UILabel(numberOfLines: 0)
        label.textAlignment = .center
        return label
    }()
    private let directorLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: 14, weight: .light))
    private let writerLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: 14, weight: .light))
    private let actorsLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: 14, weight: .light))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.edgesToSuperview()
        
        let posterView = setupPosterView()
        let infoView = setupInfoView()
        let staffView = setupStaffView()
        let stackView = UIStackView(arrangedSubviews: [posterView, infoView, staffView])
        stackView.axis = .vertical
        stackView.spacing = 20
        scrollView.addSubview(stackView)
        stackView.edges(to: scrollView.contentLayoutGuide)
        stackView.widthToSuperview()
    }
    
    func update(with details: MovieDetails) {
        posterImageView.kf.setImage(with: URL(string: details.poster), options: [.onFailureImage(#imageLiteral(resourceName: "missing-icon")), .transition(.fade(0.2))])
        titleLabel.text = details.title
        yearLabel.text = details.year
        categoriesLabel.text = details.genre
        durationLabel.text = details.runtime
        ratingLabel.text = "⭐ \(details.imdbRating)"
        synopsisLabel.text = details.plot
        scoreLabel.text = "Score\n\(details.imdbRating)"
        reviewsLabel.text = "Reviews\n\(details.imdbVotes)"
        directorLabel.text = "Director: \(details.director)"
        writerLabel.text = "Writer: \(details.writer)"
        actorsLabel.text = "Actors: \(details.actors)"
    }
    
    private func setupPosterView() -> UIView {
        let posterView = UIView()
        posterView.addSubview(posterImageView)
        posterView.addSubview(yearLabel)
        posterView.addSubview(titleLabel)
        posterImageView.height(220)
        posterImageView.edgesToSuperview()
        yearLabel.leadingToSuperview(offset: 20)
        yearLabel.trailingToSuperview(offset: 20, relation: .equalOrLess)
        yearLabel.bottomToSuperview(offset: -20)
        yearLabel.topToBottom(of: titleLabel)
        titleLabel.leadingToSuperview(offset: 20)
        titleLabel.trailingToSuperview(offset: 20, relation: .equalOrLess)
        addBottomLineView(to: posterView)
        return posterView
    }
    
    private func setupInfoView() -> UIView {
        let infoView = UIView()
        let topLabelsStackView = UIStackView(arrangedSubviews: [categoriesLabel, durationLabel, ratingLabel])
        topLabelsStackView.axis = .horizontal
        topLabelsStackView.spacing = 20
        topLabelsStackView.distribution = .equalCentering
        infoView.addSubview(topLabelsStackView)
        topLabelsStackView.edgesToSuperview(excluding: .bottom, insets: .horizontal(20))
        infoView.addSubview(synopsisLabel)
        synopsisLabel.horizontalToSuperview(insets: .horizontal(20))
        synopsisLabel.topToBottom(of: topLabelsStackView, offset: 20)
        
        let bottomLabelsStackView = UIStackView(arrangedSubviews: [scoreLabel, reviewsLabel])
        bottomLabelsStackView.axis = .horizontal
        bottomLabelsStackView.spacing = 20
        infoView.addSubview(bottomLabelsStackView)
        bottomLabelsStackView.edgesToSuperview(excluding: .top, insets: .uniform(20))
        bottomLabelsStackView.topToBottom(of: synopsisLabel, offset: 20)
        addBottomLineView(to: infoView)
        return infoView
    }
    
    private func setupStaffView() -> UIView {
        let staffView = UIView()
        staffView.addSubview(directorLabel)
        directorLabel.edgesToSuperview(excluding: .bottom, insets: .horizontal(20))
        staffView.addSubview(writerLabel)
        writerLabel.topToBottom(of: directorLabel, offset: 10)
        writerLabel.horizontalToSuperview(insets: .horizontal(20))
        staffView.addSubview(actorsLabel)
        actorsLabel.topToBottom(of: writerLabel, offset: 10)
        actorsLabel.edgesToSuperview(excluding: .top, insets: .uniform(20))
        addBottomLineView(to: staffView)
        return staffView
    }
    
    private func addBottomLineView(to view: UIView) {
        let lineView = UIView.lineView()
        view.addSubview(lineView)
        lineView.bottomToSuperview()
        lineView.horizontalToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
