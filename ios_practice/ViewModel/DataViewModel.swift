//
//  DataViewModel.swift
//  ios_practice
//
//  Created by Unthinkable-mac-0050 on 12/04/23.
//

import Foundation
import UIKit

protocol ViewDelegate: NSObjectProtocol{
    func showError()
    func showLoading()
    func hideLoading()
    func reloadNews()
}

class DataViewModel{
    private var newsUIModel: NewsUiModel?
    private var newsResponseModelList: [NewsResponseModel]
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
    func toggleBackground(){
        self.viewDelegate?.showLoading()
        let networkManager = NetworkManager()
        networkManager.fetchTopHeadlines { result in
            self.viewDelegate?.hideLoading()
            switch result {
            case .success(let newsResponse):
                print(newsResponse)
                self.createCell(newsResponseModel: newsResponse)
                self.viewDelegate?.reloadNews()
            case .failure(let error):
                print(error)
                self.viewDelegate?.showError()
            }
        }
        //        ApiClient.getDataFromServer { (success, data) in
        //            self.viewDelegate?.hideLoading()
        //            if success {
        //                self.createCell(newsResponseList: data!)
        //                self.viewDelegate?.reloadNews()
        //            } else {
        //                self.viewDelegate?.showError()
        //            }
        //        }
    }
    func mapToUi(_ cell: NewsTableViewCell, index: Int, news: NewsUiModel){
        cell.title.text = news.title
        cell.sourceName.text = news.source
        cell.timeStamp.text = news.timeStamp
       cell.newsImage.load(urlString: news.urlImage, placeholderImage: UIImage(named: "PlaceholderImage"))
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
        var count: Int = 0
        for news in newsResponseModel.articles {
            count+=1
            print("///////////////////////")
            print("index: \(count) url: \(news.url?.description ?? "")")
            print("///////////////////////")
            vms.append(NewsUiModel(timeStamp: news.publishedAt.description, title: news.title, source: news.source.name, urlImage: news.urlToImage?.description ?? "", sourceUrl: news.url?.description ?? ""))
        }
        newsUiModelList = vms
    }
}
