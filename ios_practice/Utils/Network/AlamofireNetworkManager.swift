import Alamofire

class AlamofireNetworkManager: NetworkManagerProtocol {
    static var currentPage = 1
    
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        let urlString = Constants.baseURL+Constants.Endpoints.topHeadlines+"&\(Constants.Keys.apiKey)="+Constants.apiKey
        
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
