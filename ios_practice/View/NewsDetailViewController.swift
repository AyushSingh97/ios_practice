//
//  NewsDetailViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 14/04/23.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    override func loadView() {
        super.loadView()
        configureWebView()
    }
    

    func configureWebView(){
        let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
                webView.uiDelegate = self
                view = webView
    }
    func loadWebView(){
        let myURL = URL(string:"https://www.apple.com")
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
    }

}
extension UIViewController: WKUIDelegate{}
