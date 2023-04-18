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
