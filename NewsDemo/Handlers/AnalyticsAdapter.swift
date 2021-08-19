//
//  AnalyticsAdapter.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

final class AnalyticsAdapter {
    
    func sendEvent(_ param: String) {
        print("sending some parameters with \(param)")
    }
}

extension AnalyticsAdapter: ListingViewActions {
    func didSelectCell() {
        sendEvent("cell selected")
    }
}
