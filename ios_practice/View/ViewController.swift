//
//  ViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 28/03/23.
//

import UIKit

class ViewController: UIViewController, ViewDelegate {
    
    
    @IBOutlet weak var newsTableViewController: UITableView!
    
    private let dataViewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewModel.setViewDelegate(viewDelegate: self)
        newsTableViewController.dataSource = self
    }
    
    @IBAction func onTap(_ sender: Any){
        dataViewModel.toggleBackground()
    }
    func showError(){
        DispatchQueue.main.async {
            self.showAlert("Ups, something went wrong.")
            
        }
    }
    func showLoading() {
        DispatchQueue.main.async {
            
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.contentView.layer.applyShadow(
          color: .black,
          alpha: 0.1,
          x: 0,
          y: 4,
          blur: 30,
          spread: 0)
        cell.newsMainView.layer.applyCornerRadius(radius: 12)
        cell.newsView.layer.applyCornerRadius(radius: 8)
//        cell.newsImage.layer.applyCornerRadius(radius: 20)
        cell.newsImage.load(urlString: "https://ichef.bbci.co.uk/news/1024/branded_news/12856/production/_129326857_gettyimages-1163603288.jpg", placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
}
