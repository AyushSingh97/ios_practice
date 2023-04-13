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
        // let cellVM = dataViewModel.getCellViewModel( at: indexPath )
//        cell.lblTitle.text = cellVM.titleText
//        cell.lblSubTitle.text = cellVM.subTitleText
        return cell
    }
    
    
}
