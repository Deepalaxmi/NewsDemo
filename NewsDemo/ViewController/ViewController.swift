//
//  ViewController.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel: NewsViewModel!
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetUp()

    }

    func initialSetUp(){
        let imageNibCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(imageNibCell, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.dataSource = self
        loadingIndicatorView.color = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5961579623)
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
        
        viewModel = NewsViewModel(client: NewsClient(), delegate: self)
        viewModel.fetchNewsItem()
    }

}

//MARK: NewsViewModelDelegate
extension ViewController: NewsViewModelDelegate{
    func onFetchCompleted(with newIndepathsToReload: [IndexPath]?) {
        loadingIndicatorView.stopAnimating()
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        debugPrint("onFetchFailed")
        loadingIndicatorView.stopAnimating()
        self.showToast(message: reason, seconds: 2.0)
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell{
            cell.configure(cellViewModel: viewModel.cellViewModel[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
