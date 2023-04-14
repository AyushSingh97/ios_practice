//
//  NetworkManager.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 13/04/23.
//

import Foundation
/**
 ```
 let networkManager = NetworkManager()
 networkManager.fetchTopHeadlines { result in
     switch result {
     case .success(let newsResponse):
         print(newsResponse)
     case .failure(let error):
         print(error)
     }
 }
 ```
 */
class NetworkManager {
    private let apiKey = "d665ac8e352c4fd1914c09a715c394d9"
    
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponseModel.self, from: data)
                completion(.success(newsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case emptyData
}
