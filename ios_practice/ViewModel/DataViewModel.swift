//
//  DataViewModel.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import Foundation
import UIKit

protocol ViewDelegate: NSObjectProtocol{
    func toggleBgColor(color: UIColor)
}

class DataViewModel{
    private var loading: Bool = false
    weak private var viewDelegate: ViewDelegate?
    
    func setViewDelegate(viewDelegate: ViewDelegate?){
        self.viewDelegate = viewDelegate
    }
    func isLoading() -> Bool{
        return (self.loading == true) ? true : false
    }
    func toggleBackground(){
        self.loading = true
        ApiClient.getDataFromServer { (success, data) in
            if success {
                self.viewDelegate?.toggleBgColor(color: data!.backgroundColor)
            } else {
                self.viewDelegate?.toggleBgColor(color: .red)
            }
            self.loading = false
        }
    }
}
