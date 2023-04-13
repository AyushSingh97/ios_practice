//
//  ViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 28/03/23.
//

import UIKit

class ViewController: UIViewController, ViewDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    private let dataViewModel = DataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewModel.setViewDelegate(viewDelegate: self)
    }
    
    @IBAction func onTap(_ sender: Any){
        dataViewModel.toggleBackground()
    }
    func toggleBgColor(color: UIColor) {
        DispatchQueue.main.async {self.bgView.backgroundColor = color}
    }
    func showError(){
        DispatchQueue.main.async {self.showAlert("Ups, something went wrong.")}
    }
    func showLoading() {
        DispatchQueue.main.async {self.toggleButton.isEnabled = false}
    }
    func hideLoading() {
        DispatchQueue.main.async {self.toggleButton.isEnabled = true}
    }
}
