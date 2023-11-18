//
//  MovieItemCollectionViewCell.swift
//  Homework 18
//
//  Created by salome on 11.11.23.
//

import UIKit

final class MovieItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
   private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
     let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    
    private lazy var titleGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, genreLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    private func addSubview() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleGenreStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
       
        
        NSLayoutConstraint.activate([
            titleGenreStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            titleGenreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleGenreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        
    }
    
    
    func setImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
            }
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        setImage(from: movie.posterPath)
    }
}



