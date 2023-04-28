//  UIViewController+Extension.swift
//  MyProject
//
//  Created by Ayush Singh on 28/04/2023.
//

import UIKit

/// This extension adds custom styling methods to the UIViewController class
extension UIViewController{
    
    /**
     Sets the appbar style for the current view controller
     - Parameters:
        - appbar: The UINavigationItem object to which the style is applied
     
     ### Usage Example: ###
     ````
     override func viewDidLoad() {
         super.viewDidLoad()
         setAppbarStyle(navigationItem)
     }
     ````
     */
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
    
    /**
     Sets the toggle button image for the current view controller
     - Parameters:
        - toggleButton: The UIBarButtonItem object to which the image is applied
     
     ### Usage Example: ###
     ````
     override func viewDidLoad() {
         super.viewDidLoad()
         setToggleButton(toggleBarButtonItem)
     }
     ````
     */
    func setToggleButton(_ toggleButton: UIBarButtonItem!){
        if(toggleButton.image == Constants.Images.listImageIcon){
            toggleButton.image = Constants.Images.gridImageIcon
        }
        else{
            toggleButton.image = Constants.Images.listImageIcon
        }
    }
}
