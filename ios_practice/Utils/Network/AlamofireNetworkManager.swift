//  AlamofireNetworkManager.swift
//  NetworkManager
//  Created by Ayush Singh on 28/04/23.
//

import Alamofire

/// This is a class created for managing network requests using Alamofire library
class AlamofireNetworkManager: NetworkManagerProtocol {
    
    /// This is a static variable for maintaining the current page number while fetching paginated results
    static var currentPage = 1
    
    /**
     This function fetches the top headlines from the news API and returns the response using completion block.
     - Parameter completion: A completion block that passes a result of type `Result<NewsResponseModel, NetworkError>` containing the response from the API.
     */
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        let urlString = Constants.baseURL + Constants.Endpoints.topHeadlines + "&\(Constants.Keys.apiKey)=" + Constants.apiKey
        
        AF.request(urlString).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let data = try? JSONSerialization.data(withJSONObject: value) else {
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let newsResponse = try decoder.decode(NewsResponseModel.self, from: data)
                    completion(.success(newsResponse))
                } catch {
                    completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                }
            case .failure(let error):
                if let data = response.data,
                   let errorMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = errorMessage["message"] as? String {
                    completion(.failure(NetworkError(message: message)))
                } else {
                    completion(.failure(NetworkError(message: error.localizedDescription)))
                }
            }
        }
    }
    
    /**
     Call this function to fetch paginated news from top headlines using Alamofire.
     
     - Parameters:
     - page: page number to fetch news articles from.
     - pageSize: Number of articles to fetch per page.
     - completion: Completion block that will give either NewsResponseModel or NetworkError.
     
     ### Usage Example: ###
     ````
     let networkManager = AlamofireNetworkManager()
     networkManager.fetchTopHeadlinesPaginated(page: 2, pageSize: 20) { result in
     switch result {
     case .success(let newsResponse):
     print(newsResponse)
     case .failure(let error):
     print(error)
     }
     }
     ````
     */
    func fetchTopHeadlinesPaginated(page: Int, pageSize: Int, completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        let urlString = Constants.baseURL+Constants.Endpoints.topHeadlines+"&\(Constants.Keys.apiKey)="+Constants.apiKey+"&page=\(page)&pageSize=\(pageSize)"
        
        if(AlamofireNetworkManager.currentPage == page){
            AF.request(urlString).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let data = try? JSONSerialization.data(withJSONObject: value) else {
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
                            } else {
                                AlamofireNetworkManager.currentPage += 1
                                completion(.success(newsResponse))
                            }
                        } else {
                            completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                        }
                        
                    } catch {
                        completion(.failure(NetworkError(message: Constants.Messages.somethingWentWrong)))
                    }
                    
                case .failure(let error):
                    if let data = response.data,
                       let errorMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = errorMessage["message"] as? String {
                        completion(.failure(NetworkError(message: message)))
                    } else {
                        completion(.failure(NetworkError(message: error.localizedDescription)))
                    }
                }
            }
        }
    }
}
