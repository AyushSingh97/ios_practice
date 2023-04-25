import UIKit

struct Constants {
    static let baseURL = "https://newsapi.org"
    static let appbarTitle = "Global News"
    ///
    /// Get Api Key from: https://newsapi.org/register
    ///
    static let apiKey = "d22285cdb51247b49a95df82e268f38f"
    struct Endpoints {
        static let topHeadlines = "/v2/top-headlines?country=us"
    }
    
    struct ViewControllers {
        static let main = "Main"
        static let newsDetail = "NewsDetailViewController"
        static let newCollectionViewCell = "NewCollectionViewCell"
    }
    
    struct Identifiers {
        static let newsTableCell = "newsTableCell"
        static let newsCollectionCell = "newsCollectionCell"
        static let newCollectionCell = "newNewsCollectionCell"
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
