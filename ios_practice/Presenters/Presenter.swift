///
/// Presenter.swift
///
/// This file contains the Presenter class, which acts as an intermediary between the View and the Service layers.
///
/// Created by Unthinkable-mac-0050 on 11/04/23.
///

import Foundation
import UIKit

///
/// The ViewDelegate protocol defines methods that the Presenter can call to update the View layer.
///
protocol ViewDelegate: NSObjectProtocol {
    ///
    /// This method is called by the Presenter to update the background color of the View layer.
    ///
    /// - Parameter color: The new color of the background.
    ///
    func toggleBgColor(color: UIColor)
    
    ///
    /// This method is called by the Presenter to update the title of the label in the View layer.
    ///
    /// - Parameter title: The new title of the label.
    ///
    func toggleLabel(title: String)
}

///
/// The Presenter class acts as an intermediary between the View and the Service layers.
///
class Presenter{
    
    // MARK: - Properties
    
    private let service: Service
    weak private var viewDelegate: ViewDelegate?
    
    // MARK: - Initialization
    
    ///
    /// Initializes a new instance of the Presenter class.
    ///
    /// - Parameter service: The Service instance to use for communication with the backend.
    ///
    init(service: Service){
        self.service = service
    }
    
    // MARK: - Public Methods
    
    ///
    /// Sets the ViewDelegate instance that the Presenter should use for updating the View layer.
    ///
    /// - Parameter viewDelegate: The ViewDelegate instance to use.
    ///
    func setViewDelegate(viewDelegate: ViewDelegate?){
        self.viewDelegate = viewDelegate
    }
    
    ///
    /// Toggles the background color of the View layer.
    ///
    /// - Parameter colorName: The name of the color to toggle to.
    ///
    func toggleColor(colorName: String){
        service.getColor(colorName: colorName, callBack: { [weak self] model in
            
            if let model = model {
                self?.viewDelegate?.toggleBgColor(color: model.color)
            }
        })
    }
    
    ///
    /// Toggles the title of the label in the View layer.
    ///
    /// - Parameter text: The current text of the label.
    ///
    func toggleLabel(text: String){
        service.getLabel(text: text, callBack: { [weak self] model in
            
            if let model = model {
                self?.viewDelegate?.toggleLabel(title: model.label)
            }
        })
    }
}
