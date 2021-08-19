//
//  ListingViewActionsHandler.swift
//  NewsDemo
//
//  Created by Deepalaxmi Khangembam on 19/08/21.
//  Copyright © 2021 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

protocol ListingViewActions {
    func didSelectCell()
}

final class ListingViewActionsCompositeHandler: ListingViewActions  {
    private var handlers: [ListingViewActions]
    
    init(handlers: [ListingViewActions]) {
        self.handlers = handlers
    }
    
    func didSelectCell() {
        handlers.forEach {
            $0.didSelectCell()
        }
    }
    
}
