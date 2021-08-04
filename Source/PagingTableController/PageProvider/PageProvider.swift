//
//  PageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Foundation

// MARK: - PageResult

public struct PageResult<T> {
    
    // MARK: - Public properties
    
    let newItems: [T]
    let allItems: [T]
    let hasMore: Bool
}

// MARK: - PageProvider

public protocol PageProvider {
    
    // MARK: - Types
    
    associatedtype T
    
    typealias Completion = (Result<PageResult<T>, Error>) -> Void
    
    // MARK: - Public methods
    
    func getFirstPage( _ completion: @escaping Completion)
    func getNextPage(_ completion: @escaping Completion)
}
