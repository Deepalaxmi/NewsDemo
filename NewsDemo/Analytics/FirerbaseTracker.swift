//
//  FirerbaseTracker.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

final class FirerbaseTracker: ListingViewActions {
    private func sendFirebaseEvent(_ param: String) {
        print("sending event to Firebase with \(param)")
    }
    
    func didSelectCell() {
        sendFirebaseEvent("cell selected")
    }
}
