//
//  UIViewController+Extensions.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func hideAlert() {
            if let alert = self.presentedViewController as? UIAlertController {
                alert.dismiss(animated: true, completion: nil)
            }
        }
}
