//  CALayer+Extensions.swift
//  Created by Ayush Singh on 28/04/2023
//

import UIKit

extension CALayer {
    
    /**
     Apply shadow to CALayer
     - Parameters:
        - color: Shadow color. Default is black.
        - alpha: Shadow opacity. Default is 0.5.
        - x: Horizontal shadow offset. Default is 0.
        - y: Vertical shadow offset. Default is 2.
        - blur: Shadow blur radius. Default is 4.
        - spread: Shadow spread radius. Default is 0.
     
     ### Usage Example: ###
     ````
     myView.layer.applyShadow(color: UIColor.black, alpha: 0.3, x: 1.0, y: 3.0, blur: 6.0, spread: 0)
     ````
     */
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
        masksToBounds = true
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    /**
     Apply corner radius to CALayer
     - Parameters:
        - radius: Corner radius value
     
     ### Usage Example: ###
     ````
     myView.layer.applyCornerRadius(radius: 10.0)
     ````
     */
    func applyCornerRadius(radius: CGFloat) {
        cornerRadius = radius
        masksToBounds = true
    }
}
