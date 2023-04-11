//
//  Service.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 11/04/23.
//

import Foundation
import UIKit
class Service{
    func getColor(colorName:String, callBack: (Model?) -> Void) {
        if(colorName == "RED"){
            callBack(Model(color: .purple, label: "PURPLE"))
            return
        }
        callBack(Model(color: .red, label: "RED"))
        return
    }
    func getLabel(text:String, callBack: (Model?) -> Void) {
        if(text == "RED"){
            callBack(Model(color: .purple, label: "PURPLE"))
            return
        }
        callBack(Model(color: .red, label: "RED"))
        return
    }
}
