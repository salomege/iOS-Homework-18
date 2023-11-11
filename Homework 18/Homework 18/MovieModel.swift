//
//  MovieModel.swift
//  Homework 18
//
//  Created by salome on 11.11.23.
//

import Foundation


let URLString = "https://www.omdbapi.com/"

struct Movie: Codable {
    let title: String
    let genre: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case genre = "Genre"
        case poster = "Poster"
    }
}

func fetchMovieFromURL(url: URL, completion: @escaping (Result<Movie, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            let noDataError = NSError(domain: "https://www.omdbapi.com/", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
            completion(.failure(noDataError))
            return
        }

        do {
            let decoder = JSONDecoder()
            let movie = try decoder.decode(Movie.self, from: data)
            completion(.success(movie))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}


