//
//  MovieCell.swift
//  MoviesAPP
//
//  Created by Karolina Attekita on 28/03/22.
//

import Foundation
import UIKit
import Kingfisher

final class MovieCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, genres, rateStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var title: UILabel = {
       let label = UILabel()
        label.font = Fonts.large(.regular).font
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genres: UILabel = {
       let label = UILabel()
        label.font = Fonts.small(.regular).font
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var poster: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [star, rateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var star: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(systemName: "star")
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var rateLabel: UILabel = {
       let label = UILabel()
        label.font = Fonts.medium(.regular).font
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Movie) {
        title.text = model.name
        genres.text = model.genres?.joined(separator: ", ")
        rateLabel.text = model.rating?.average?.toString()
        
        guard let image = model.image?.medium,
              let imageUrl = URL(string: image) else {
            return
        }
        
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: imageUrl)
    }
}

extension MovieCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(blurView)
        containerView.addSubview(poster)
        containerView.addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            blurView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            poster.topAnchor.constraint(equalTo: containerView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            poster.widthAnchor.constraint(equalToConstant: 100),
            poster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 16),
            
            star.widthAnchor.constraint(equalToConstant: 24),
            star.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 150)
        heightConstraint.isActive = true
        heightConstraint.priority = UILayoutPriority.init(999)
    }

    func applyAdditionalChanges() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
}
