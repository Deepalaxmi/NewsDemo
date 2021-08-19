//
//  CompositeFeedLoaderWithFallback.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

extension FeedLoader {
    func fallback(_ fallback: FeedLoader) -> FeedLoader {
        CompositeFeedLoaderWithFallback(primary: self, fallback: fallback)
    }
    
    func retry(_ retryCount: UInt) -> FeedLoader {
        var loader: FeedLoader = self
        for _ in 0..<retryCount {
            loader = loader.fallback(self)
        }
        return loader
    }
}

struct CompositeFeedLoaderWithFallback: FeedLoader {
    
    let primary: FeedLoader
    let fallback: FeedLoader
    
    func loadItems(completion: @escaping (Result<[NewsItemViewModel], DataResponseError>) -> Void) {
        primary.loadItems { result in
            switch result {
            case .success(_):
                completion(result)
            case .failure(_):
                fallback.loadItems(completion: completion)
            }
        }
    }
    
}
