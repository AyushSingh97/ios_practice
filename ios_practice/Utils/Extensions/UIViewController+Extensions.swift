// UIViewController+Alert.swift
// Created by Ayush Singh on 28/04/23.

import UIKit

extension UIViewController {
    
    /**
     Call this function to show an alert with a message in the current View Controller.
     - Parameters:
        - message: A string value representing the message to display in the alert.
     
     ### Usage Example: ###
     ````
     self.showAlert("Error: Invalid input.")
     ````
     */
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: Constants.Messages.emptyString, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Messages.ok, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Call this function to hide any alert that may currently be displayed in the current View Controller.
     
     ### Usage Example: ###
     ````
     self.hideAlert()
     ````
     */
    func hideAlert() {
        if let alert = self.presentedViewController as? UIAlertController {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
