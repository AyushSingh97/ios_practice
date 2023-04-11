//
//  ViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 28/03/23.
//

import UIKit

class ViewController: UIViewController, ViewDelegate {
    
    private let presenter = Presenter(service: Service())
    func toggleBgColor(color: UIColor) {
        backgroundView.backgroundColor = color
    }
    
    func toggleLabel(title: String) {
        label.text = title
    }
    

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(viewDelegate: self)
    }

    @IBAction func onToggle(_ sender: UIButton) {
        presenter.toggleColor(colorName: backgroundView.backgroundColor == UIColor.red ? "RED": "PURPLE")
        presenter.toggleLabel(text: label.text!)
//        _toggleColor()
//        _toggleLabel()
    }
    
//    func _toggleColor(){
//        if(backgroundView.backgroundColor == UIColor.purple){
//            backgroundView.backgroundColor = UIColor.red
//            return
//        }
//        backgroundView.backgroundColor = UIColor.purple
//        return
//    }
//    func _toggleLabel(){
//        if(label.text?.uppercased() == "PURPLE"){
//            label.text = "RED"
//            return
//        }
//        label.text = "PURPLE"
//        return
//    }
}

