//
//  NewsViewModel.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func onFetchCompleted(with newIndepathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class NewsViewModel {
    weak var delegate: NewsViewModelDelegate?
    
    private let client: APIClient
    var cellViewModel: [NewsItem] = []
    
    init(client: APIClient, delegate: NewsViewModelDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func fetchNewsItem()  {
        
        if !Helper.isInternetAvailable() {
            self.cellViewModel  = DataManager.fetchData()
            self.delegate?.onFetchCompleted(with: .none)
            return
        }
        
        guard let client = client as? NewsClient else{
            return
        }
        
        let newsEndpoint = NewsEndpoint.news
        client.fetchNews(endpoint: newsEndpoint) { (result) in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
//                    print(news)
                    self.cellViewModel = news.NewsItem
                    DataManager.saveData(dataList: news.NewsItem)
                    self.delegate?.onFetchCompleted(with: .none)
//                    }
                }
            case .failure(let error):
                //If the request fails, inform the delegate of the reason for that failure and show the user a specific alert
                print(error)
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            }
            
        }
        
    }
    
   
    
}
