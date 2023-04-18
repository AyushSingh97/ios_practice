import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var appbar: UINavigationItem!
    @IBOutlet weak var newsTableViewController: UITableView!
    
    private let dataViewModel = DataViewModel()
    
    var navigationBarAppearance = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewModel.setViewDelegate(viewDelegate: self)
        newsTableViewController.dataSource = self
        newsTableViewController.delegate = self
        dataViewModel.toggleBackground()
        
    }
    @IBAction func onTap(_ sender: Any){
        dataViewModel.toggleBackground()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
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


extension ViewController: ViewDelegate{
    func showError(){
        DispatchQueue.main.async {
            self.showAlert(Constants.Messages.somethingWentWrong)
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
}
