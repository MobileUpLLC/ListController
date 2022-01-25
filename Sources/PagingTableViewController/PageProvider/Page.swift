//
//  Page.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Foundation

public struct Page<T> {
        
    public let items: [T]
    public let hasMore: Bool
    
    public init(items: [T], hasMore: Bool) {
        self.items = items
        self.hasMore = hasMore
    }
}
