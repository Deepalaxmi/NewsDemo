//
//  LocalFeedLoader.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

struct LocalFeedLoaderAdapter: FeedLoader {
    
    var cache: CacheDataManager
    
    func loadItems(completion: @escaping (Result<[NewsItemViewModel], DataResponseError>) -> Void) {
        let items = cache.fetchData()
        if items.isEmpty {
            completion(.failure(.other))
        } else {
            completion(.success(items))
        }
    }
}
