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
    
    private(set) var factory: ViewComposableFactory
    private(set) var navigation: UINavigationController
    
    init(viewFactory: ViewComposableFactory, navigation: UINavigationController) {
        self.factory = viewFactory
        self.navigation = navigation
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
    
    func presentViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigation.visibleViewController?.present(viewController, animated: animated)
    }
    
    func setRootViewController(_ vc: UIViewController, _ animated: Bool = true ) {
        self.navigation.setViewControllers([vc], animated: animated)
        AppDelegate.shared.window?.rootViewController = navigation
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    func showNewsListing() {
        let listingVC = factory.composeView(type: .newsListingWithDetail)
        setRootViewController(listingVC)
    }
}
