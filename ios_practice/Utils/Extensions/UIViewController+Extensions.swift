import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: Constants.Messages.emptyString, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: Constants.Messages.ok, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func hideAlert() {
            if let alert = self.presentedViewController as? UIAlertController {
                alert.dismiss(animated: true, completion: nil)
            }
        }
}
