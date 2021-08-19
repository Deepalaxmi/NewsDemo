//
//  FirebaseAnalyticsTracker.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

final class GoogleAnalyticsTracker: ListingViewActions {
    private func sendGAEvent(_ param: String) {
        print("sending event to Google Analytics with \(param)")
    }
    
    func didSelectCell() {
        sendGAEvent("cell selected")
    }
}
