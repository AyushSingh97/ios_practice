//
//  ViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 28/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appbar: UINavigationItem!
    @IBOutlet weak var newsTableViewController: UITableView!
    
    private let dataViewModel = DataViewModel()
    
    var navigationBarAppearance = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupNavigationBar()
        dataViewModel.setViewDelegate(viewDelegate: self)
        newsTableViewController.dataSource = self
        newsTableViewController.delegate = self
        dataViewModel.toggleBackground()
        // appbar.titleView?.backgroundColor = .b
        
    }
    private func setupNavigationBar(){
        let titleImageView = UIImageView(image: UIImage(named: "GlobalNewsIcon"))
        
         titleImageView.contentMode = .scaleAspectFit
        
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 80).offsetBy(dx: 10, dy: 0)
         // titleImageView.backgroundColor = .red
        
         navigationItem.titleView = titleImageView
    }
    @IBAction func onTap(_ sender: Any){
        dataViewModel.toggleBackground()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        var news = dataViewModel.newsUiModelList[indexPath.row]
        dataViewModel.mapToUi(cell, index: indexPath.row, news: news)
        cell = beautifyCell(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("//////////////////////////////")
        print("Selected index: \(indexPath.row)")
        print("//////////////////////////////")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newsViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsViewController.urlString = dataViewModel.newsUiModelList[indexPath.row].sourceUrl
        self.present(newsViewController, animated: false)
    }
    func beautifyCell(_ cell: NewsTableViewCell) -> NewsTableViewCell{
        cell.contentView.layer.applyShadow(
          color: .black,
          alpha: 0.1,
          x: 0,
          y: 4,
          blur: 30,
          spread: 0)
        cell.newsMainView.layer.applyCornerRadius(radius: 12)
        cell.newsView.layer.applyCornerRadius(radius: 8)
        return cell
    }
}


extension ViewController: ViewDelegate{
    func showError(){DispatchQueue.main.async {self.showAlert("Ups, something went wrong.")}}
    func showLoading() {
        DispatchQueue.main.async {
            
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            
        }
    }
    func reloadNews() {
        DispatchQueue.main.async { self.newsTableViewController.reloadData() }
    }
}
