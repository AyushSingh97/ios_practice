// Logger.swift
// Created by Ayush Singh on 28/04/23.
//

import Foundation

/// This class is used for logging messages in the project.
class Logger {
    
    /**
     Call this function to log the message with the start and end marker.
     - Parameters:
        - message: Pass the message that needs to be logged.
        - separator: A string value that separates the message and markers. Default is " ".
     
     ### Usage Example: ###
     ````
     Logger.log("This is a sample log message.")
     ````
     */
    
    static func log(_ message: String, separator: String = " ") {
        print("\n\n======================[INFO START]=============================")
        print("\n\n\(message)")
        print("\n\n======================[INFO END]=============================\n\n")
    }
}

