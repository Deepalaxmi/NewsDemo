//
//  NewsEndpoint.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

enum NewsEndpoint: Endpoint{
    case news
    
    var baseUrl: String{
        return NewsClient.baseUrl
    }
    
    var path: String{
        switch self {
        case .news:
            return "/feeds/newsdefaultfeeds.cms"
        }
    }
    
    var urlParameters: [URLQueryItem]{
        switch self {
        case .news:
            return [
                URLQueryItem(name: "feedtype", value: "sjson"),
            ]
        }
    }
    
}
