// File: NetworkManagerFactory.swift
//
// This file contains the definition of the NetworkManagerFactory class, along with the NetworkManagerType enum, the NetworkManagerProtocol protocol, and the NetworkError struct. The author of this file is Ayush Singh.
//

import Foundation
import Alamofire

/// Defines the types of network managers that can be created by the NetworkManagerFactory class.
enum NetworkManagerType {
    case alamofire
    case defaultImplementation
}

/// This class is responsible for creating instances of network managers based on the specified type.
class NetworkManagerFactory {
    
    /**
     Creates and returns an instance of a network manager.
     
     - Parameter type: The type of network manager to create.
     
     - Returns: An instance of a network manager that conforms to the NetworkManagerProtocol protocol.
     */
    static func createNetworkManager(type: NetworkManagerType) -> NetworkManagerProtocol {
        switch type {
        case .alamofire:
            return AlamofireNetworkManager()
        case .defaultImplementation:
            return DefaultNetworkManager()
        }
    }
}

/// This protocol defines the methods that a network manager must implement.
protocol NetworkManagerProtocol {
    
    /**
     Fetches the top headlines and passes the results to the completion handler.
     
     - Parameter completion: The completion handler to call when the request completes. The handler takes a single parameter of type Result<NewsResponseModel, NetworkError>.
     */
    func fetchTopHeadlines(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void)
    
    /**
     Fetches a paginated set of top headlines and passes the results to the completion handler.
     
     - Parameters:
        - page: The page number to fetch.
        - pageSize: The number of results to include on each page.
        - completion: The completion handler to call when the request completes. The handler takes a single parameter of type Result<NewsResponseModel, NetworkError>.
     */
    func fetchTopHeadlinesPaginated(page: Int, pageSize: Int, completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void)
}

/// This struct represents an error that can occur during a network request.
struct NetworkError: Error {
    let message: String
}

// End of file.
