//
//  PageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Foundation

public struct PageResult<T> {
        
    public let newItems: [T]
    public let allItems: [T]
    public let hasMore: Bool
    
    public init(newItems: [T], allItems: [T], hasMore: Bool) {
        self.newItems = newItems
        self.allItems = allItems
        self.hasMore = hasMore
    }
}

public protocol PageProvider {
        
    associatedtype T
    
    typealias Completion = (Result<PageResult<T>, Error>) -> Void
        
    func getFirstPage( _ completion: @escaping Completion)
    func getNextPage(_ completion: @escaping Completion)
}
