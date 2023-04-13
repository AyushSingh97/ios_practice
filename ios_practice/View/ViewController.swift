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
        // If button has been pressed
        if(!dataViewModel.isLoading()){
            toggleButton.isEnabled = false
            dataViewModel.toggleBackground()
        }
    }
    func toggleBgColor(color: UIColor) {
        
        DispatchQueue.main.async {
            self.bgView.backgroundColor = color
            self.toggleButton.isEnabled = true
           }
       
    }
}
