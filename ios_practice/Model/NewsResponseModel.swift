import Foundation
struct NewsResponseModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}

struct ArticleModel: Codable {
    let source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date
    let content: String?
}

struct SourceModel: Codable {
    let id: String?
    let name: String
}
