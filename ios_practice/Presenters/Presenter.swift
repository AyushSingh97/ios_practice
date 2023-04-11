//
//  Presenter.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 11/04/23.
//

import Foundation
import UIKit
protocol ViewDelegate: NSObjectProtocol {
    func toggleLabel(title : String)
    func toggleBgColor(color : UIColor)
}
class Presenter{
    private let service: Service
    weak private var viewDelegate: ViewDelegate?
    
    init(service: Service){
        self.service = service
    }
    func setViewDelegate(viewDelegate: ViewDelegate?){
        self.viewDelegate = viewDelegate
    }
    
    func toggleColor(colorName: String){
        service.getColor(colorName: colorName, callBack: { [weak self] model in
            
            if let model = model {
                self?.viewDelegate?.toggleBgColor(color: model.color)
            }
        })
    }
    func toggleLabel(text: String){
        service.getLabel(text: text, callBack: { [weak self] model in
            
            if let model = model {
                self?.viewDelegate?.toggleLabel(title: model.label)
            }
        })
    }
}
