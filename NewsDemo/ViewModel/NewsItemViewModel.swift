//
//  NewsItem.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

struct News: Codable {
    var NewsItem: [NewsItemViewModel] = []
}

struct NewsItemViewModel: Codable {
    var NewsItemId: String
    var HeadLine: String
    var DateLine: String
    var Image: Image?
}

struct Image: Codable {
    var Photo: String
    var Thumb: String
}
