//
//  NewsClient.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//http://timesofindia.indiatimes.com/feeds/newsdefaultfeeds.cms?feedtype=sjson

import Foundation

class NewsClient: APIClient {
    
    static let baseUrl = "https://timesofindia.indiatimes.com"
    
    func fetchNews(endpoint: NewsEndpoint, completion: @escaping (ResultCustom<News>) -> Void){
        let request = endpoint.request
        get(request: request, completion: completion)
    }
    
    
    
}
