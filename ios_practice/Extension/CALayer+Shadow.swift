//
//  CALayer+SketchShadow.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 14/04/23.
//

import UIKit

extension CALayer {
  func applyShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
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
    func applyCornerRadius(radius: CGFloat) {
            cornerRadius = radius
            masksToBounds = true
        }
}
