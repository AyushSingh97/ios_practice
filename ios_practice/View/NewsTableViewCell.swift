/**
 A table view cell class to display news articles in a table view. It contains outlets for a news view, news image, news main view, source name, title, and time stamp.
 
 ### Usage Example: ###
  ````
    // Dequeue the table view cell and set it up
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
    cell.title.text = "Breaking News"
    cell.sourceName.text = "CNN"
    cell.timeStamp.text = "3 hours ago"
  ````
 */
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsMainView: UIView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
