//
//  ApiClient.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import Foundation
import UIKit

public struct ApiClient {
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: [NewsResponseModel]? )->() ){
        DispatchQueue.global().async {
            var dummyData: NewsResponseModel
            sleep(2)
            // dummyData = NewsResponseModel(backgroundColor: UIColor.green)
             
            // complete(false, nil)
            // sleep(2)
            // complete(true, [dummyData, dummyData, dummyData])
            // If server gives an error, use "complete(false, nil)"
        }
    }
}
