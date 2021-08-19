//
//  ViewControllerFactory.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation
import UIKit

enum ViewType {
    case newsListing
    case newsListingWithFallback
    case newsListingWithMutlipleRetry
    case newsListingWithDetail
    case detailPage
}

protocol ViewComposableFactory {
    func composeView(type: ViewType) -> UIViewController
}

final class ViewComposerFactory: ViewComposableFactory {
    
    func composeView(type: ViewType) -> UIViewController {
        switch type {
        case .newsListing:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
            
            let api = RemoteFeedLoaderAdapter(apiClient: NewsClient())
            let cache = LocalFeedLoaderAdapter(cache: CacheDataManager.shared)
            let feedLoader = CompositeFeedLoaderWithFallback(primary: cache, fallback: api)
            vc.service = feedLoader
            return vc
            
        case .newsListingWithFallback:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
            
            let api = RemoteFeedLoaderAdapter(apiClient: NewsClient())
            let cache = LocalFeedLoaderAdapter(cache: CacheDataManager.shared)
            vc.service = api.fallback(cache)
            return vc
            
        case .newsListingWithMutlipleRetry:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
            
            let api = RemoteFeedLoaderAdapter(apiClient: NewsClient())
            let cache = LocalFeedLoaderAdapter(cache: CacheDataManager.shared)
            vc.service = api.retry(3).fallback(cache)
            return vc
        case .newsListingWithDetail:
//            let vc = ListingWithDetailViewController(nibName: ListingWithDetailViewController.className, bundle: nil)
            
            //action handlers
            let router = AppDelegate.shared.navigationRouter
            let analyticsHandler = AnalyticsAdapter()
            let viewActionsHandler = ListingViewActionsCompositeHandler(handlers: [router,analyticsHandler])
            let vc = ListingWithDetailViewController(actionsHandler: viewActionsHandler)

            //To load data
            let api = RemoteFeedLoaderAdapter(apiClient: NewsClient())
            let cache = LocalFeedLoaderAdapter(cache: CacheDataManager.shared)
            let feedLoader = CompositeFeedLoaderWithFallback(primary: cache, fallback: api)
            vc.service = feedLoader
            vc.title = "Listing Page"
            return vc
        case .detailPage:
            let vc = DetailPageViewController(nibName: DetailPageViewController.className, bundle: nil)
            vc.title = "Detail Page"
            return vc
        }
    }
}
