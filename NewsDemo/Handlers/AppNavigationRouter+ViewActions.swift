//
//  AppNavigationRouter+ViewActions.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

extension AppNavigationRouter: ListingViewActions {
    
    func didSelectCell() {
        let detailVC = self.factory.composeView(type: .detailPage)
        self.pushViewController(detailVC)
    }
}
