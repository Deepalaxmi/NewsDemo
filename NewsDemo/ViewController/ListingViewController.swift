//
//  ViewController.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

protocol FeedLoader {
    func loadItems(completion: @escaping (Result<[NewsItemViewModel],DataResponseError>) -> Void)
}

class ListingViewController: UIViewController {
    
    private var items: [NewsItemViewModel] = []
    var service: FeedLoader?
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetUp()
    }
    
    func initialSetUp(){
        setUpUI()
        fetchData()
    }
    
}

//MARK: Private Methods
extension ListingViewController {
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
        loadingIndicatorView.color = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5961579623)
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
    }
}

extension ListingViewController: UITableViewDataSource{
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
