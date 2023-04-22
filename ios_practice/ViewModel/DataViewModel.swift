import Foundation
import UIKit

protocol ViewDelegate: NSObjectProtocol{
    func showError(_ errorMessage: String)
    func showLoading()
    func hideLoading()
    func reloadNews()
    func toggleNewsAppearance()
}

class DataViewModel{
    private var newsUIModel: NewsUiModel?
    private var newsResponseModelList: [NewsResponseModel]
    private var isFetching = false
    private var pageNumber = 1
    private let networkManager = NetworkManager()
    var newsUiModelList: [NewsUiModel] = [NewsUiModel](){
        didSet {
            self.viewDelegate?.reloadNews()
        }
    }
    private var loading: Bool
    weak private var viewDelegate: ViewDelegate?
    
    init(){
        self.newsResponseModelList = [NewsResponseModel]()
        self.loading = false
    }
    
    func setViewDelegate(viewDelegate: ViewDelegate?){
        self.viewDelegate = viewDelegate
    }
    func isLoading() -> Bool{
        return (self.loading == true) ? true : false
    }
    func fetchTopHeadlines(){
        self.viewDelegate?.showLoading()
        fetchNewsPaginated()
        
    }
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
    func mapToUi(_ cell: NewsTableViewCell, index: Int, news: NewsUiModel){
        cell.title.text = news.title
        cell.sourceName.text = news.source
        cell.timeStamp.text = news.timeStamp
        cell.newsImage.load(urlString: news.urlImage, placeholderImage: Constants.Images.placeHolderImage)
    }
    func mapToUi(_ cell: NewsCollectionViewCell, index: Int, news: NewsUiModel){
        cell.newsTitle.text = news.title
        cell.newsImageView.load(urlString: news.urlImage, placeholderImage: Constants.Images.placeHolderImage)
    }
    func openWebView(_ urlString: String, navigationController: UINavigationController?){
        let storyBoard = UIStoryboard(name: Constants.ViewControllers.main, bundle: nil)
        let newsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllers.newsDetail) as! NewsDetailViewController
        newsViewController.urlString = urlString
        newsViewController.loadWebView()
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    func changeNewsAppearance(){
        viewDelegate?.toggleNewsAppearance()
    }
    // This method returns the number of cells to be displayed in the tableview
    var numberOfCells: Int {
        return newsUiModelList.count
    }
    
    // This method returns the DataListCellViewModel for the cell at the given indexPath
    func getCellViewModel( at indexPath: IndexPath ) -> NewsUiModel {
        return newsUiModelList[indexPath.row]
    }
    
    // This method creates the DataListCellViewModel for each data object and adds them to the cellViewModels array
    func createCell(newsResponseModel: NewsResponseModel){
        self.newsResponseModelList = []
        var vms = [NewsUiModel]()
        for news in newsResponseModel.articles {
            vms.append(NewsUiModel(timeStamp: news.publishedAt.description, title: news.title, source: news.source.name, urlImage: news.urlToImage?.description ?? Constants.Messages.emptyString, sourceUrl: news.url?.description ?? Constants.Messages.emptyString))
        }
        self.newsUiModelList += vms
    }
}
