/**
 This file defines a Constants struct that contains various constants used in the project.
 
 The baseURL constant contains the base URL of the News API used in the project.
 The appbarTitle constant contains the title of the appbar used in the project.
 The apiKey constant contains the API key for the News API. It is obtained from the News API website.
 
 The Endpoints struct contains the endpoint for fetching top headlines from the News API.
 
 The ViewControllers struct contains the storyboard identifiers for the view controllers used in the project.
 
 The Identifiers struct contains the reuse identifiers for the table view cell and collection view cell used in the project.
 
 The Keys struct contains the key for the API key parameter used in the project.
 
 The Messages struct contains various messages used in the project.
 
 The Colors struct contains the accent color used in the project, which is obtained from the Assets folder.
 
 The Images struct contains the placeholder image used in the project and the icons for the list and grid view modes.
 */
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
        static let newsCollectionViewCell = "NewsCollectionViewCell"
    }
    
    struct Identifiers {
        static let newsTableCell = "newsTableCell"
        static let newsCollectionViewCell = "newsCollectionViewCell"
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
