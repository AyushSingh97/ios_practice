//
//  ViewController.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 28/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    weak private var _bgColor: UIColor!
    override func viewDidLoad() {
        super.viewDidLoad()
        _bgColor = _bgColor ?? UIColor.red
        _updateBgColor()
    }

    @IBAction func onToggle(_ sender: UIButton) {
        _updateBgColor()
    }
    
    func _updateBgColor(){
        _bgColor = _toggleColor(_bgColor)
        backgroundView.backgroundColor = _bgColor
    }
    
    func _toggleColor(_ currentColor: UIColor) -> UIColor {
        if(currentColor == UIColor.purple){
            return UIColor.red
        }
        else if(currentColor == UIColor.red){
            return UIColor.purple
        }
        return UIColor.green
    }
}

