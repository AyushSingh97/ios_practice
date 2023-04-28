// NewCollectionViewCell.swift
//
// NewsCollectionViewCell
//
// Created by Ayush Singh on April 25, 2023.
//
// This file defines a custom UICollectionViewCell class for displaying news in a UICollectionView. The class contains three outlets: mainContentView, newsTitle, and newsImageView, which are used to display the news content. It also contains an awakeFromNib function that is called when the cell is loaded from the nib.

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    /// The main content view of the cell, used to display news content.
    @IBOutlet weak var mainContentView: UIView!
    
    /// The label used to display the title of the news article.
    @IBOutlet weak var newsTitle: UILabel!
    
    /// The image view used to display an image associated with the news article.
    @IBOutlet weak var newsImageView: UIImageView!
    
    /**
     Called when the cell is loaded from the nib. This function is used to perform any necessary initialization of the cell.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
