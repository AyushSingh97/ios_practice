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
//        cell.newsView.layer.cornerRadius = 8
//        cell.newsView.layer.shadowOffset =  CGSize(width: 0, height: 4)
//        cell.newsView.layer.shadowColor = UIColor.black.cgColor
//        cell.newsView.layer.shadowOpacity = 0.5
//        cell.newsView.layer.shadowRadius = 10
        cell.contentView.layer.applySketchShadow(
          color: .black,
          alpha: 0.1,
          x: 0,
          y: 4,
          blur: 30,
          spread: 0)
        return cell
    }
    
    
}
extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
