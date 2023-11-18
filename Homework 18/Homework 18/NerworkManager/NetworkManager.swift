//
//  NetworkManager.swift
//  Homework 18
//
//  Created by salome on 17.11.23.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey =  "70dce981525cd8cfbfe0d94053fda913"
    
    private init() {}
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlStr = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
