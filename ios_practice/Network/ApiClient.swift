//
//  ApiClient.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import Foundation
import UIKit

public struct ApiClient {
    
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: Data? )->() ){
        DispatchQueue.global().async {
            sleep(2)
            let dummyData: Data = Data(backgroundColor: colorList.randomElement()!)
            
            // complete(false, nil)
            // sleep(2)
            complete(true, dummyData)
            // If server gives an error, use "complete(false, nil)"
        }
    }
    
    static var colorList: [UIColor] = [.red, .purple, .green, .blue]
}
