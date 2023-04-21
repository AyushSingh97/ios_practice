import UIKit
extension UIViewController{
    func setAppbarStyle(_ appbar: UINavigationItem!) {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .white
        label.shadowColor = .clear
        label.text = Constants.appbarTitle
        appbar.titleView = label
    }
    func setToggleButton(_ toggleButton: UIButton!){
        if(toggleButton.currentImage == Constants.Images.listImageIcon){
            toggleButton.setImage(Constants.Images.gridImageIcon, for: .normal)
        }
        else{
            toggleButton.setImage(Constants.Images.listImageIcon, for: .normal)
        }
        
    }
}
