import UIKit

struct Constants {
    static let baseURL = "https://newsapi.org"
    static let appbarTitle = "Global News"
    static let apiKey = "d665ac8e352c4fd1914c09a715c394d9"
    struct Endpoints {
        static let topHeadlines = "/v2/top-headlines?country=us"
    }
    
    struct ViewControllers {
        static let main = "Main"
        static let newsDetail = "NewsDetailViewController"
    }
    
    struct Identifiers {
        static let newsTableCell = "newsTableCell"
        static let newsCollectionCell = "newsCollectionCell"
    }
    
    struct Keys {
        static let apiKey = "apiKey"
    }
    
    struct Messages {
        static let ok = "Ok"
        static let emptyString = ""
        static let somethingWentWrong = "Something went wrong..."
        static let cellNotExistInStoryboard = "Cell not exists in storyboard"
    }
    
    struct Colors {
        // static let primary = UIColor(red: 0.23, green: 0.42, blue: 0.64, alpha: 1.0)
        static let accentColor = UIColor(named: "AccentColor")
    }
    struct Images{
        static let placeHolderImage = UIImage(named: "PlaceholderImage")
        static let listImageIcon = UIImage(named: "list")
        static let gridImageIcon = UIImage(named: "grid")
    }
}
