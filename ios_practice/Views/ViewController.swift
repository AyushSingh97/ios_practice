import UIKit

/// This is the main view controller responsible for showing the UI and reacting to user interactions
class ViewController: UIViewController, ViewDelegate {
    /// The presenter that handles the business logic and communicates with the data source
    private let presenter = Presenter(service: Service())

    /// Toggle the background color of the view
    /// - Parameter color: The new color to set the background view to
    func toggleBgColor(color: UIColor) {
        backgroundView.backgroundColor = color
    }

    /// Toggle the text of the label
    /// - Parameter title: The new title to set the label to
    func toggleLabel(title: String) {
        label.text = title
    }

    /// The label that displays the text
    @IBOutlet weak var label: UILabel!

    /// The view that represents the background of the app
    @IBOutlet weak var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view delegate for the presenter
        presenter.setViewDelegate(viewDelegate: self)
    }

    /// Triggered when the toggle button is pressed
    @IBAction func onToggle(_ sender: UIButton) {
        // Toggle the background color and label text using the presenter
        presenter.toggleColor(colorName: backgroundView.backgroundColor == UIColor.red ? "RED": "PURPLE")
        presenter.toggleLabel(text: label.text!)
    }

    /*
    /// Toggles the color of the background view between purple and red
    func _toggleColor(){
        if(backgroundView.backgroundColor == UIColor.purple){
            backgroundView.backgroundColor = UIColor.red
            return
        }
        backgroundView.backgroundColor = UIColor.purple
        return
    }

    /// Toggles the text of the label between purple and red
    func _toggleLabel(){
        if(label.text?.uppercased() == "PURPLE"){
            label.text = "RED"
            return
        }
        label.text = "PURPLE"
        return
    }
    */
}
