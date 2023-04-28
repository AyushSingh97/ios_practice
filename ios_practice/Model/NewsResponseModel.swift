// NewsResponseModel.swift
// Created by Ayush Singh

import Foundation

/// This struct represents the response model of News API
struct NewsResponseModel: Codable {
    
    /// The status of the API response
    let status: String
    
    /// The total number of results returned by the API
    let totalResults: Int
    
    /// An array of article models
    let articles: [ArticleModel]
    
    /**
     Returns the JSON string representation of the struct
     - Returns: A String representing the JSON data of the struct
     */
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

/// This struct represents an article model
struct ArticleModel: Codable {
    
    /// The source of the article
    let source: SourceModel
    
    /// The author of the article
    let author: String?
    
    /// The title of the article
    let title: String
    
    /// The description of the article
    let description: String?
    
    /// The URL of the article
    let url: URL?
    
    /// The URL of the image of the article
    let urlToImage: URL?
    
    /// The date and time when the article was published
    let publishedAt: Date
    
    /// The content of the article
    let content: String?
}

/// This struct represents the source model
struct SourceModel: Codable {
    
    /// The ID of the source
    let id: String?
    
    /// The name of the source
    let name: String
}
