import Foundation
class DefaultNetworkManager: NetworkManagerProtocol{
    static var currentPage = 1
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
    
    func fetchTopHeadlinesPaginated(page: Int, pageSize: Int, completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
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
                // print("Cannot load more data...")
            }
    }
    
    
}
