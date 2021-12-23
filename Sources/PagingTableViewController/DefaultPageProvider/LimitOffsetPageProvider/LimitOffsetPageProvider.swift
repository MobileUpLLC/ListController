//
//  LimitOffsetPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation

// MARK: - LimitOffsetPageProvider

public protocol LimitOffsetPageProvider: PageProvider, AnyObject {
    
    // MARK: - Public properties
    
    var allItems: [T] { get set }
    
    var requestLimit: Int { get }
    
    /// Should be zero by initial state.
    var loadedPagesCount: Int { get set }
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<T>, Error>) -> Void)
}

// MARK: - LimitOffsetPageProvider + Default Implementation

public extension LimitOffsetPageProvider {
    
    // MARK: - Public properties
    
    var requestLimit: Int { 20 }
    
    var requestOffset: Int { loadedPagesCount * requestLimit }
    
    // MARK: - Public methods
    
    func getFirstPage(_ completion: @escaping Completion) {
        getItems(limit: requestLimit, offset: requestOffset) { [weak self] page in
            let pageResult = page.map { [weak self] (page) -> PageResult<T> in
                self?.resetAllItems(page.items)
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            completion(pageResult)
        }
    }
    
    func getNextPage(_ completion: @escaping Completion) {
        getItems(limit: requestLimit, offset: requestOffset) { [weak self] page in
            let pageResult = page.map { [weak self] (page) -> PageResult<T> in
                self?.appendNewItems(page.items)
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            completion(pageResult)
        }
    }
    
    func appendNewItems(_ items: [T]) {
        loadedPagesCount += 1
        allItems += items
    }
    
    func resetAllItems(_ items: [T]) {
        loadedPagesCount = 1
        allItems = items
    }
}
