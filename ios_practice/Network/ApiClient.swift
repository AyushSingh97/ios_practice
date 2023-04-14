//
//  ApiClient.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import Foundation
import UIKit

public struct ApiClient {
    static var count: Int = 0
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: News? )->() ){
        DispatchQueue.global().async {
            var dummyData: News
            sleep(2)
            if(count % 2 == 0){
                dummyData = News(backgroundColor: UIColor.purple)
            }
            else{
                dummyData = News(backgroundColor: UIColor.green)
            }
             
            count += 1
            // complete(false, nil)
            // sleep(2)
            complete(true, dummyData)
            // If server gives an error, use "complete(false, nil)"
        }
    }
    static func getRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
