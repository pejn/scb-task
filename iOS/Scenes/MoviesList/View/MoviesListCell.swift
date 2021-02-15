//
//  MoviesListCell.swift
//  scb-recruitment-task (iOS)
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

import UIKit
import Kingfisher

final class MoviesListCell: UICollectionViewCell {
    static let identifier = "MoviesListCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel(numberOfLines: 2, font: .boldSystemFont(ofSize: 17))
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .systemBackground
        return titleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        backgroundColor = .systemBackground
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        
        posterImageView.edgesToSuperview()
        titleView.edgesToSuperview(excluding: .top)
        titleLabel.edgesToSuperview(insets: .uniform(10))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, imageUrl: URL?) {
        posterImageView.kf.setImage(with: imageUrl, options: [.onFailureImage(#imageLiteral(resourceName: "missing-icon")), .transition(.fade(0.2))])
        titleLabel.text = title
    }
}
