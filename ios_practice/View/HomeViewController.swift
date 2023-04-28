// HomeViewController.swift
// Created by Ayush Singh
// This file contains the HomeViewController class, which is responsible for managing the home screen of the app.
// This view controller displays two views, a table view and a collection view, that can be toggled with a button in the navigation bar.
// The class also communicates with a DataViewModel instance to fetch data from an external API and update the views.

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    @IBOutlet weak var appbar: UINavigationItem!
    @IBOutlet weak var newsTableViewController: UITableView!
    @IBOutlet weak var newsCollectionViewController: UICollectionView!
    
    // MARK: - Properties
    
    private let dataViewModel = DataViewModel()
    var navigationBarAppearance = UINavigationBar.appearance()
    let apiDebouncer = DebouncerManager(delay: 0.5)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the API debouncer
        apiDebouncer.setCallback({
            self.dataViewModel.fetchTopHeadlines()
        })
        
        // Set up the app bar style and toggle button
        setAppbarStyle(appbar)
        setToggleButton(toggleButton)
        
        // Set up the table view and collection view
        setNewsTableView()
        setNewsCollectionView()
        
        // Set up the data view model
        dataViewModel.setViewDelegate(viewDelegate: self)
        dataViewModel.setIsListViewModeActive(toggleButton)
        dataViewModel.fetchTopHeadlines()
    }
    
    // MARK: - Private Functions
    
    /// Set up the news table view.
    func setNewsTableView(){
        newsTableViewController.dataSource = self
        newsTableViewController.delegate = self
        tableView.isHidden = false
    }
    
    /// Set up the news collection view.
    func setNewsCollectionView(){
        newsCollectionViewController.dataSource = self
        newsCollectionViewController.delegate = self
        initializeCollectionCell()
        collectionView.isHidden = true
    }
    
    /// Initialize the collection view cell.
    func initializeCollectionCell(){
        let nibCell = UINib(nibName: Constants.ViewControllers.newsCollectionViewCell, bundle: nil)
        newsCollectionViewController.register(nibCell, forCellWithReuseIdentifier: Constants.Identifiers.newsCollectionViewCell)
    }
    
    // MARK: - IBActions
    
    /// Action that triggers when the user taps anywhere on the screen.
    @IBAction func onTap(_ sender: Any){
        dataViewModel.fetchTopHeadlines()
    }
    
    /// Action that triggers when the user toggles the list/grid view button.
    @IBAction func onToggle(_ sender: UIBarButtonItem) {
        dataViewModel.changeNewsAppearance()
        dataViewModel.setIsListViewModeActive(toggleButton)
    }
}

// Extension for UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout in HomeViewController
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /**
     Returns the number of cells in the collection view.
     
     - Parameter:
        - collectionView: The collection view requesting this information.
        - section: An index number identifying a section in collectionView.
     
     - Returns: The number of cells.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    /**
     Asks the data source for a cell to insert in a particular location of the collection view.
     
     - Parameter:
        - collectionView: The collection view requesting this information.
        - indexPath: The index path that specifies the location of the item.
     
     - Returns: An instance of NewsCollectionViewCell.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.newsCollectionViewCell, for: indexPath) as? NewsCollectionViewCell else {
            fatalError(Constants.Messages.cellNotExistInStoryboard)
        }
        let news = dataViewModel.newsUiModelList[indexPath.row]
        dataViewModel.mapToUi(cell, index: indexPath.row, news: news)
        cell = beautifyCell(cell)
        return cell
    }
    
    /**
     Tells the delegate that the item at the specified index path was selected.
     
     - Parameter:
        - collectionView: The collection view object that is notifying you of the selection change.
        - indexPath: The index path of the cell that was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataViewModel.openWebView(dataViewModel.newsUiModelList[indexPath.row].sourceUrl, navigationController: navigationController)
    }
    
    /**
     Asks the delegate for the size of the specified item’s cell.
     
     - Parameter:
        - collectionView: The collection view requesting this information.
        - layout: The layout object requesting the information.
        - indexPath: The index path of the item.
     
     - Returns: The size of the item’s cell.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio: CGFloat = 343/274
        let width = (self.view.frame.width - 48)/2
        let height = width/aspectRatio
        return CGSize(width: width, height: height)
    }
}

// HomeViewController extension conforming to UITableViewDataSource and UITableViewDelegate protocols
// This extension is responsible for handling table view data source and delegate methods.

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    /**
     Tells the data source to return the number of rows in a given section of a table view.
     
     - Parameters:
        - tableView: The table-view object requesting this information.
        - section: An index number identifying a section in tableView.
     
     - Returns: The number of rows in section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    /**
     Asks the data source for a cell to insert in a particular location of the table view.
     
     - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path that locates a row in tableView.
     
     - Returns: An object inheriting from UITableViewCell that the table view can use for the specified row. An assertion is raised if you return nil.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.newsTableCell, for: indexPath) as? NewsTableViewCell else {
            fatalError(Constants.Messages.cellNotExistInStoryboard)
        }
        let news = dataViewModel.newsUiModelList[indexPath.row]
        dataViewModel.mapToUi(cell, index: indexPath.row, news: news)
        cell = beautifyCell(cell)
        return cell
    }
    
    /**
     Tells the delegate that the specified row is now selected.
     
     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataViewModel.openWebView(dataViewModel.newsUiModelList[indexPath.row].sourceUrl, navigationController: navigationController)
    }
    
    /**
     Beautify NewsTableViewCell by applying corner radius and shadow
     
     - Parameters:
        - cell: A NewsTableViewCell object to be beautified
     
     - Returns: A beautified NewsTableViewCell object
     */
    func beautifyCell(_ cell: NewsTableViewCell) -> NewsTableViewCell {
        cell.contentView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 4,
            blur: 30,
            spread: 0)
        cell.newsMainView.layer.applyCornerRadius(radius: 12)
        cell.newsView.layer.applyCornerRadius(radius: 8)
        return cell
    }
    
    /**
     Beautify NewsCollectionViewCell by applying corner radius and shadow
     
     - Parameters:
        - cell: A NewsCollectionViewCell object to be beautified
     
     - Returns: A beautified NewsCollectionViewCell object
     */
    func beautifyCell(_ cell: NewsCollectionViewCell) -> NewsCollectionViewCell {
        cell.contentView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 4,
            blur: 30,
            spread: 0)
        cell.mainContentView.layer.applyCornerRadius(radius: 12)
        cell.newsImageView.layer.applyCornerRadius(radius: 12)
        return cell
    }
}

/**
   This extension of the HomeViewController class conforms to the UIScrollViewDelegate protocol and contains a function named "scrollViewDidScroll", which is called when the user scrolls the scroll view.
 */

extension HomeViewController: UIScrollViewDelegate{
    
    /**
       This function calculates the bottom offset of the scroll view and checks if the user has scrolled 80% of the way down the table view. If so, it calls the "call" function of the "apiDebouncer" object.
     
       - Parameters:
           - scrollView: The scroll view whose delegate is HomeViewController.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomOffset = scrollView.contentOffset.y + scrollView.bounds.height
        let maxOffset = scrollView.contentSize.height
        let scrollPercent = (bottomOffset / maxOffset) * 100
        
        if scrollPercent >= 80 {
            apiDebouncer.call()
        }
    }
}

// This extension is created for the HomeViewController class that conforms to the ViewDelegate protocol.
// The purpose of this extension is to implement the ViewDelegate methods that are used to display and update news-related content in the app.
extension HomeViewController: ViewDelegate {
    
    /**
     This method is called when an error message needs to be displayed to the user.
     
     - Parameter errorMessage: The error message to be displayed in the alert.
     
     ### Usage Example: ###
     ````
     showError("Failed to load news data")
     ````
     */
    func showError(_ errorMessage: String){
        DispatchQueue.main.async {
            self.showAlert(errorMessage)
        }
    }
    
    /**
     This method is called when the news-related content is being loaded and a loading indicator needs to be displayed to the user.
     */
    func showLoading() {
    }
    
    /**
     This method is called when the news-related content has finished loading and the loading indicator needs to be hidden.
     */
    func hideLoading() {
    }
    
    /**
     This method is called when the news-related content needs to be refreshed, typically after the user pulls to refresh.
     
     ### Usage Example: ###
     ````
     reloadNews()
     ````
     */
    func reloadNews() {
        DispatchQueue.main.async {
            self.newsTableViewController.reloadData()
            self.newsCollectionViewController.reloadData()
        }
    }
    
    /**
     This method is called when the user toggles the appearance of the news-related content between a table view and a collection view.
     It toggles the visibility of the table view and the collection view, and updates the toggle button accordingly.
     
     ### Usage Example: ###
     ````
     toggleNewsAppearance()
     ````
     */
    func toggleNewsAppearance(){
        tableView.isHidden = !tableView.isHidden
        newsTableViewController.reloadData()
        collectionView.isHidden = !collectionView.isHidden
        newsCollectionViewController.reloadData()
        setToggleButton(toggleButton)
    }
}
