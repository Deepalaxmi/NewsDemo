//
//  ListingWithDetailViewController.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class ListingWithDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private var items: [NewsItemViewModel] = []
    var service: FeedLoader?
    private var actionsHandler: ListingViewActions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(actionsHandler != nil)
        precondition(service != nil)
        initialSetUp()
    }
    
    convenience init(actionsHandler: ListingViewActions){
        self.init(nibName: ListingWithDetailViewController.className, bundle: .main)
        self.actionsHandler = actionsHandler
    }

}
//MARK: Private Methods
extension ListingWithDetailViewController {
    func initialSetUp(){
        setUpUI()
        fetchData()
    }
    
    private func fetchData() {
        service?.loadItems(completion: handleAPIResult)
    }
    
    private func handleAPIResult(_ result: Result<[NewsItemViewModel],DataResponseError>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let items):
                self?.items = items
                self?.loadingIndicatorView.stopAnimating()
                self?.tableView.reloadData()
                
            case .failure(let error):
                self?.loadingIndicatorView.stopAnimating()
                self?.showToast(message: error.reason, seconds: 2.0)
            }
        }
    }
    
    private func setUpUI() {
        let imageNibCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(imageNibCell, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        loadingIndicatorView.color = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5961579623)
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
    }
}

extension ListingWithDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell{
            cell.configure(cellViewModel: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension ListingWithDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionsHandler.didSelectCell()
    }
}
