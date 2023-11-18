//
//  ViewController.swift
//  Homework 18
//
//  Created by salome on 11.11.23.
//

import UIKit

final class MoviesListViewController: UIViewController {
    let movieItemCollectionViewCell = MovieItemCollectionViewCell()
    
    var movies: [Movie] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchMovies()
    }
    
    private func setup() {
        view.backgroundColor = UIColor(red: 26/255.0, green: 34/255.0, blue: 50/255.0, alpha: 1)
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: "MovieItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchMovies() {
        NetworkManager.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieItemCell", for: indexPath) as? MovieItemCollectionViewCell else {fatalError("Unable to dequeue MovieItemCollectionViewCell")
        }
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
        
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + flowLayout.minimumInteritemSpacing
        
        let width = Int((collectionView.bounds.width - totalSpace) / 2)
        let height = 278
        
        return CGSize(width: width, height: height)
    }
    
}





