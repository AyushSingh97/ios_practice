import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var appbar: UINavigationItem!
    @IBOutlet weak var newsTableViewController: UITableView!
    
    @IBOutlet weak var newsCollectionViewController: UICollectionView!
    private let dataViewModel = DataViewModel()
    
    var navigationBarAppearance = UINavigationBar.appearance()
    
    let apiDebouncer = DebouncerManager(delay: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            apiDebouncer.setCallback({
                self.dataViewModel.fetchTopHeadlines()
            })
        setAppbarStyle(appbar)
        setToggleButton(toggleButton)
        setNewsTableView()
        setNewsCollectionView()
        dataViewModel.setViewDelegate(viewDelegate: self)
        dataViewModel.setIsListViewModeActive(toggleButton)
        dataViewModel.fetchTopHeadlines()
    }
    func setNewsTableView(){
        newsTableViewController.dataSource = self
        newsTableViewController.delegate = self
        tableView.isHidden = false
    }
    func setNewsCollectionView(){
        newsCollectionViewController.dataSource = self
        newsCollectionViewController.delegate = self
        collectionView.isHidden = true
    }
    @IBAction func onTap(_ sender: Any){
        dataViewModel.fetchTopHeadlines()
    }
    
    @IBAction func onToggle(_ sender: UIButton) {
        dataViewModel.changeNewsAppearance()
        dataViewModel.setIsListViewModeActive(toggleButton)
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.newsCollectionCell, for: indexPath) as? NewsCollectionViewCell else {
            fatalError(Constants.Messages.cellNotExistInStoryboard)
        }
        let news = dataViewModel.newsUiModelList[indexPath.row]
        dataViewModel.mapToUi(cell, index: indexPath.row, news: news)
        cell = beautifyCell(cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataViewModel.openWebView(dataViewModel.newsUiModelList[indexPath.row].sourceUrl, navigationController: navigationController)
    }
    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.newsTableCell, for: indexPath) as? NewsTableViewCell else {
            fatalError(Constants.Messages.cellNotExistInStoryboard)
        }
        let news = dataViewModel.newsUiModelList[indexPath.row]
        dataViewModel.mapToUi(cell, index: indexPath.row, news: news)
        cell = beautifyCell(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataViewModel.openWebView(dataViewModel.newsUiModelList[indexPath.row].sourceUrl, navigationController: navigationController)
    }
    
    func beautifyCell(_ cell: NewsTableViewCell) -> NewsTableViewCell{
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
    func beautifyCell(_ cell: NewsCollectionViewCell) -> NewsCollectionViewCell{
        cell.contentView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 4,
            blur: 30,
            spread: 0)
        cell.mainContentView.layer.applyCornerRadius(radius: 12)
        return cell
    }
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the bottom offset of the table view
        let bottomOffset = scrollView.contentOffset.y + scrollView.bounds.height
        let maxOffset = scrollView.contentSize.height
        let scrollPercent = (bottomOffset / maxOffset) * 100
        // Check if the user has scrolled 80% of the way down the table view
            if scrollPercent >= 80 {
                 apiDebouncer.call()
            }
    }
}


extension ViewController: ViewDelegate{
    func showError(_ errorMessage: String){
        DispatchQueue.main.async {
            self.showAlert(errorMessage)
        }
    }
    func showLoading() {
    }
    func hideLoading() {
    }
    func reloadNews() {
        DispatchQueue.main.async {
            self.newsTableViewController.reloadData()
            self.newsCollectionViewController.reloadData()
        }
    }
    func toggleNewsAppearance(){
        tableView.isHidden = !tableView.isHidden
        newsTableViewController.reloadData()
        collectionView.isHidden = !collectionView.isHidden
        newsCollectionViewController.reloadData()
        setToggleButton(toggleButton)
    }
}
