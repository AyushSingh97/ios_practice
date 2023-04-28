//  DefaultNetworkManager.swift
//  NewsApp
//  Created by Ayush Singh on 28/04/23.
//

import Foundation

/// The DefaultNetworkManager class is responsible for handling network calls related to News API
class DefaultNetworkManager: NetworkManagerProtocol{
    
    /// This is the current page variable which is initially set to 1 and gets incremented after each successful pagination call.
    static var currentPage = 1
    
    /**
     Fetches top headlines using News API.

     - Parameter completion: A completion handler that returns a `Result` object either with the `NewsResponseModel` data on success or a `NetworkError` object on failure.
     */
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void){
        let urlString = Constants.baseURL+Constants.Endpoints.topHeadlines+"&\(Constants.Keys.apiKey)="+Constants.apiKey
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if let httpResponse = response as? HTTPURLResponse, let data = data,
                   let errorMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = errorMessage["message"] as? String {
                    completion(.failure(NetworkError(message: message)))
                    return
                }
                completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponseModel.self, from: data)
                completion(.success(newsResponse))
                return
            } catch {
                completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                return
            }
        }
        task.resume()
    }
    
    /**
     Fetches top headlines using News API with pagination.

     - Parameters:
        - page: The page number to be fetched.
        - pageSize: The number of articles to be fetched per page.
        - completion: A completion handler that returns a `Result` object either with the `NewsResponseModel` data on success or a `NetworkError` object on failure.
     */
    func fetchTopHeadlinesPaginated(page: Int, pageSize: Int, completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        /*
         Create the URL string with page number and page size, and check if it's the same page that was fetched earlier. If it's the same page, fetch the data from the API, else do nothing.
         */
        let urlString = Constants.baseURL+Constants.Endpoints.topHeadlines+"&\(Constants.Keys.apiKey)="+Constants.apiKey+"&page=\(page)&pageSize=\(pageSize)"
            
        if(DefaultNetworkManager.currentPage == page){
            Logger.log(urlString)
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse, let data = data,
                        let errorMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                        let message = errorMessage["message"] as? String {
                            print(message)
                        completion(.failure(NetworkError(message: message)))
                        return
                    }
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let newsResponse = try decoder.decode(NewsResponseModel.self, from: data)
                    if(newsResponse.status == "ok"){
                        if(newsResponse.articles.count < pageSize){
                            completion(.success(newsResponse))
                            return
                        }
                        DefaultNetworkManager.currentPage += 1
                        completion(.success(newsResponse))
                        return
                    }
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    return
                } catch(let e) {
                    print(httpResponse)
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                }
            }
            task.resume()
        }
        else{
            // If the requested page is not the same as the last fetched page, do nothing.
        }
    }
}
