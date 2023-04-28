// NewsDetailViewController.swift
//
//  NewsDetailViewController
//  Created by Ayush Singh
//

import UIKit
import WebKit

/// A view controller that displays a web page with news details.
class NewsDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// A web view used to display the news details.
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    /// The URL of the news page to be displayed.
    var urlString: String = ""
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the web view.
        loadWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set the frame of the web view to match the view bounds.
        webView.frame = view.bounds
    }
    
    // MARK: - Private Functions
    
    /**
     Loads the web view with the URL specified in `urlString`.
     */
    func loadWebView(){
        guard let myURL = URL(string: urlString) else{
            return
        }
        let myRequest = URLRequest(url: myURL)
        webView?.load(myRequest)
    }
    
    // MARK: - IBActions
    
    /**
     Pops the current view controller from the navigation stack.
     
     - Parameter sender: The bar button item that triggered the action.
     */
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

