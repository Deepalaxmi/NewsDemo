//
//  RemoteFeedLoader.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

struct RemoteFeedLoaderAdapter: FeedLoader {
    
    var apiClient: APIClient
    
    func loadItems(completion: @escaping (Result<[NewsItemViewModel], DataResponseError>) -> Void) {
        
        if !Helper.isInternetAvailable() {
            completion(.failure(.network))
            return
        }
        
        guard let client = apiClient as? NewsClient else{
            completion(.failure(.other))
            return
        }
        
        let newsEndpoint = NewsEndpoint.news
        client.fetchNews(endpoint: newsEndpoint) { (result) in
            switch result {
            case .success(let news):
                CacheDataManager.saveData(dataList: news.NewsItem)
                completion(.success(news.NewsItem))
            case .failure(let error):
                //If the request fails, inform the delegate of the reason for that failure and show the user a specific alert
                print(error)
                completion(.failure(error))
            }
            
        }
  
    }
}
