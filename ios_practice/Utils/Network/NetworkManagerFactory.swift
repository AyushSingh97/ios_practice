
import Foundation



import Foundation
import Alamofire

enum NetworkManagerType {
    case alamofire
    case defaultImplementation
}

class NetworkManagerFactory {
    static func createNetworkManager(type: NetworkManagerType) -> NetworkManagerProtocol {
        switch type {
        case .alamofire:
            return AlamofireNetworkManager()
        case .defaultImplementation:
            return DefaultNetworkManager()
        }
    }
}

protocol NetworkManagerProtocol {
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void)
    func fetchTopHeadlinesPaginated(page: Int, pageSize: Int, completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void)
}

struct NetworkError: Error {
    let message: String
}
