//
//  NewsDetailViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 14/04/23.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    var urlString: String = ""
    
    override func viewDidLoad() {
        loadWebView()
    }
    
    func loadWebView(){
        print("url = \(urlString)")
        guard let myURL = URL(string:self.urlString) else{
            return
        }
        let myRequest = URLRequest(url: myURL)
        webView?.load(myRequest)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
