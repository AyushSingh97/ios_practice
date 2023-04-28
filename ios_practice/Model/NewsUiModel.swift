// NewsUiModel.swift
// Created by Ayush Singh

import Foundation
import UIKit

/// This is a class representing a UI model for news articles
class NewsUiModel {
    
    /// The timestamp of the news article as a string
    var timeStamp: String
    
    /// The title of the news article
    var title: String
    
    /// The source of the news article
    var source: String
    
    /// The URL for the image associated with the news article
    var urlImage: String
    
    /// The URL for the source of the news article
    var sourceUrl: String
    
    /**
     Initializes a NewsUiModel instance
     
     - Parameters:
        - timeStamp: The timestamp of the news article as a string
        - title: The title of the news article
        - source: The source of the news article
        - urlImage: The URL for the image associated with the news article
        - sourceUrl: The URL for the source of the news article
     */
    init(timeStamp: String, title: String, source: String, urlImage: String, sourceUrl: String) {
        self.timeStamp = timeStamp
        self.title = title
        self.source = source
        self.urlImage = urlImage
        self.sourceUrl = sourceUrl
    }
}
