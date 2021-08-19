//
//  DataManager.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

struct Constant {
    struct userDefault {
        static let newsItem = "newsItem"
    }
}

class CacheDataManager {
    static var shared = CacheDataManager()
    private init() {
    }
    
    static func saveData(dataList: [NewsItemViewModel]){
        do {
            let webData = try JSONEncoder().encode(dataList)
            UserDefaults.standard.set(webData, forKey: Constant.userDefault.newsItem)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData() -> [NewsItemViewModel]{
        guard let data = UserDefaults.standard.data(forKey: Constant.userDefault.newsItem) else{
            return []
        }
        do{
            let list = try JSONDecoder().decode([NewsItemViewModel].self, from: data)
            return list
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
}
