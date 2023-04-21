import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var appbar: UINavigationItem!
    @IBOutlet weak var newsTableViewController: UITableView!
    
    private let dataViewModel = DataViewModel()
    
    var navigationBarAppearance = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppbarStyle(appbar)
        setToggleButton(toggleButton)
        dataViewModel.setViewDelegate(viewDelegate: self)
        newsTableViewController.dataSource = self
        newsTableViewController.delegate = self
        dataViewModel.fetchTopHeadlines()
        
    }
    @IBAction func onTap(_ sender: Any){
        dataViewModel.fetchTopHeadlines()
    }
    
    @IBAction func onToggle(_ sender: UIButton) {
        dataViewModel.changeNewsAppearance()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.newsCell, for: indexPath) as? NewsTableViewCell else {
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
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentScrollYOffset = scrollView.contentOffset.y
        let scrollViewFrameSize = scrollView.frame.size.height
        let totalTableHeight = newsTableViewController.contentSize.height
        if(currentScrollYOffset > totalTableHeight - scrollViewFrameSize - 300){
            dataViewModel.fetchTopHeadlines()
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
        }
    }
    func toggleNewsAppearance(){
        newsTableViewController.isHidden = !(newsTableViewController.isHidden)
        setToggleButton(toggleButton)
    }
}
