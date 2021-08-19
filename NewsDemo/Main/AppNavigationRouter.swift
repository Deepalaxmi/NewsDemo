//
//  AppNavigationRouter.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation
import UIKit

final class AppNavigationRouter {
    
    private var factory: ViewComposableFactory
    private var navigation: UINavigationController
    
    init(viewFactory: ViewComposableFactory, navigation: UINavigationController) {
        self.factory = viewFactory
        self.navigation = navigation
    }
    
    func setRootViewController(_ vc: UIViewController, _ animated: Bool = true ) {
        self.navigation.setViewControllers([vc], animated: animated)
        AppDelegate.shared.window?.rootViewController = navigation
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    func showNewsListing() {
        let listingVC = factory.composeView(type: .newsListingWithMutlipleRetry)
        setRootViewController(listingVC)
    }
}
