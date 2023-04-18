import UIKit
extension UIViewController{
    func setAppbarStyle(_ appbar: UINavigationItem!) {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 36))
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .white
        label.shadowColor = .black
        label.text = "Global News"
        appbar.titleView = label
    }
}
