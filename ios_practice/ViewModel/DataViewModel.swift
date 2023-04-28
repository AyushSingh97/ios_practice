// DataViewModel.swift
// Created by Ayush Singh on 28/04/2023.
// Copyright © 2023 Ayush Singh. All rights reserved.

import Foundation
import UIKit

/// A protocol that handles the UI update operations.
protocol ViewDelegate: NSObjectProtocol {
    
    /// This function displays the error message in case of any error.
    /// - Parameter errorMessage: The error message string.
    func showError(_ errorMessage: String)
    
    /// This function shows the loading indicator on the screen.
    func showLoading()
    
    /// This function hides the loading indicator from the screen.
    func hideLoading()
    
    /// This function reloads the news on the screen.
    func reloadNews()
    
    /// This function toggles the appearance of news between list view and collection view.
    func toggleNewsAppearance()
}

/// A class that represents the view model for the news data.
class DataViewModel {
    
    // MARK: - Properties
    
    private var newsUIModel: NewsUiModel?
    private var newsResponseModelList: [NewsResponseModel]
    private var isFetching = false
    private var pageNumber = 1
    private let networkManager = NetworkManagerFactory.createNetworkManager(type: .alamofire)
    private var isListViewModeActive = true
    var newsUiModelList: [NewsUiModel] = [NewsUiModel](){
        didSet {
            self.viewDelegate?.reloadNews()
        }
    }
    private var loading: Bool
    weak private var viewDelegate: ViewDelegate?
    
    // MARK: - Initializer
    
    init() {
        self.newsResponseModelList = [NewsResponseModel]()
        self.loading = false
    }
    
    // MARK: - Public Methods
    
    /// This function sets the view delegate for the data model.
    /// - Parameter viewDelegate: The view delegate object.
    func setViewDelegate(viewDelegate: ViewDelegate?) {
        self.viewDelegate = viewDelegate
    }
    
    /// This function checks if the data is being loaded.
    /// - Returns: A boolean value that indicates if the data is being loaded.
    func isLoading() -> Bool{
        return (self.loading == true) ? true : false
    }
    
    /// This function fetches the top headlines and displays them on the screen.
    func fetchTopHeadlines(){
        self.viewDelegate?.showLoading()
        fetchNewsPaginated()
    }
    
    /// This function sets the list view mode.
    /// - Parameter toggleButton: The toggle button that represents the list view.
    func setIsListViewModeActive(_ toggleButton: UIBarButtonItem!) {
        if(toggleButton.image == Constants.Images.listImageIcon){
            self.isListViewModeActive =  true
            return
        }
        self.isListViewModeActive =  false
        return
    }
    
    /// This function gets the list view mode.
    /// - Returns: A boolean value that indicates if the list view mode is active or not.
    func getIsListViewModeActive() -> Bool{
        return self.isListViewModeActive
    }
    
    /// This function maps the news data to the UI.
    /// - Parameters:
    ///   - cell: The cell that displays the news data.
    ///   - index: The index of the news item in the list.
    ///   - news: The news object.
    func mapToUi(_ cell: NewsTableViewCell, index: Int, news: NewsUiModel){
        cell.title.text = news.title
        cell.sourceName.text = news.source
        cell.timeStamp.text = news.timeStamp
        cell.newsImage.load(urlString: news.urlImage, placeholderImage: Constants.Images.placeHolderImage)
    }
    /// This function maps NewsUiModel to NewsCollectionViewCell's UI elements
    /// - Parameters:
    ///     - cell: The NewsCollectionViewCell to be populated with data
    ///     - index: The index of the NewsUiModel object in the array
    ///     - news: The NewsUiModel object containing news data to be mapped to the cell
    /// - Note: Make sure that the cell has all the necessary UI elements connected to it before calling this function
    func mapToUi(_ cell: NewsCollectionViewCell, index: Int, news: NewsUiModel){
        cell.newsTitle.text = news.title
        cell.newsImageView.load(urlString: news.urlImage, placeholderImage: Constants.Images.placeHolderImage)
    }

    /**
     Opens a webview with the given URL string and pushes it to the given navigation controller.
     - Parameters:
        - urlString: The URL string to load in the webview.
        - navigationController: The navigation controller to push the webview to.
     */
    func openWebView(_ urlString: String, navigationController: UINavigationController?){
        let storyBoard = UIStoryboard(name: Constants.ViewControllers.main, bundle: nil)
        let newsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllers.newsDetail) as! NewsDetailViewController
        newsViewController.urlString = urlString
        newsViewController.loadWebView()
        navigationController?.pushViewController(newsViewController, animated: true)
    }

    /**
     Toggles the appearance of the news view.
     */
    func changeNewsAppearance(){
        viewDelegate?.toggleNewsAppearance()
    }

    /// The number of NewsUiModel cells to be displayed in the tableview.
    var numberOfCells: Int {
        return newsUiModelList.count
    }

    /**
     Returns the NewsUiModel at the given index path.
     - Parameters:
        - indexPath: The index path of the cell to retrieve.
     - Returns: The NewsUiModel at the given index path.
     */
    func getCellViewModel( at indexPath: IndexPath ) -> NewsUiModel {
        return newsUiModelList[indexPath.row]
    }

    /**
     Creates NewsUiModel from the NewsResponseModel and adds them to the newsUiModelList.
     - Parameters:
        - newsResponseModel: The NewsResponseModel to map to NewsUiModel.
     */
    func createCell(newsResponseModel: NewsResponseModel){
        self.newsResponseModelList = []
        var vms = [NewsUiModel]()
        for news in newsResponseModel.articles {
            vms.append(NewsUiModel(timeStamp: news.publishedAt.description, title: news.title, source: news.source.name, urlImage: news.urlToImage?.description ?? Constants.Messages.emptyString, sourceUrl: news.url?.description ?? Constants.Messages.emptyString))
        }
        self.newsUiModelList += vms
    }

    /**
     This function fetches the news in a paginated manner or non-paginated manner as specified by the parameter `isPaginated`.
     
     - Parameters:
        - isPaginated: A boolean flag that determines whether to fetch news in a paginated manner or not. The default value is `true`.
     
     If `isFetching` flag is false, it calls the `fetchTopHeadlinesPaginated` function of the `networkManager` object to fetch news in a paginated manner with the specified page number and page size. It also calls the `hideLoading` function of the `viewDelegate` object to hide the loading indicator. When the fetch operation is complete, it sets the `isFetching` flag to true and checks the result of the operation. If the result is success, it sets the `isFetching` flag to false and logs the JSON representation of the `newsResponse` object. It also calls the `createCell` function with the `newsResponse` object to create the cells for the news items and calls the `reloadNews` function of the `viewDelegate` object to reload the news list. Finally, it increments the `pageNumber` variable.
     
     If `isFetching` flag is false and `isPaginated` is false, it calls the `fetchTopHeadlines` function of the `networkManager` object to fetch news in a non-paginated manner. It also calls the `hideLoading` function of the `viewDelegate` object to hide the loading indicator. When the fetch operation is complete, it sets the `isFetching` flag to true and checks the result of the operation. If the result is success, it sets the `isFetching` flag to false and calls the `createCell` function with the `newsResponse` object to create the cells for the news items and calls the `reloadNews` function of the `viewDelegate` object to reload the news list. If the result is failure, it sets the `isFetching` flag to false and calls the `showError` function of the `viewDelegate` object with the localized description of the error message.
     
     ### Usage Example: ###
     ````
     fetchNewsPaginated(isPaginated: true)
     ````
     */
    func fetchNewsPaginated(isPaginated: Bool = true){
        if(!self.isFetching){
            if(isPaginated){
                networkManager.fetchTopHeadlinesPaginated(page: self.pageNumber, pageSize: 5) { result in
                    self.viewDelegate?.hideLoading()
                    self.isFetching = true
                    switch result {
                    case .success(let newsResponse):
                        self.isFetching = false
                        Logger.log(newsResponse.toJson() ?? Constants.Messages.emptyString)
                        self.createCell(newsResponseModel: newsResponse)
                        self.viewDelegate?.reloadNews()
                        self.pageNumber += 1
                    case .failure(let errorMessage):
                        self.isFetching = false
                        Logger.log(errorMessage.message)
                        self.viewDelegate?.showError(errorMessage.message)
                    }
                }
            }
            else{
                networkManager.fetchTopHeadlines { result in
                    self.viewDelegate?.hideLoading()
                    self.isFetching = true
                    switch result {
                    case .success(let newsResponse):
                        self.isFetching = false
                        self.createCell(newsResponseModel: newsResponse)
                        self.viewDelegate?.reloadNews()
                    case .failure(let errorMessage):
                        self.isFetching = false
                        self.viewDelegate?.showError(errorMessage.localizedDescription)
                    }
                }
            }
        }
    }
    
}
