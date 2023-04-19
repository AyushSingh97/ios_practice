import Foundation
struct NewsResponseModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
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
