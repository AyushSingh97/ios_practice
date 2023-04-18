import Foundation
import UIKit

class NewsUiModel {
    var timeStamp: String
    var title: String
    var source: String
    var urlImage: String
    var sourceUrl: String
    
    init(timeStamp: String, title: String, source: String, urlImage: String, sourceUrl: String) {
        self.timeStamp = timeStamp
        self.title = title
        self.source = source
        self.urlImage = urlImage
        self.sourceUrl = sourceUrl
    }
}
