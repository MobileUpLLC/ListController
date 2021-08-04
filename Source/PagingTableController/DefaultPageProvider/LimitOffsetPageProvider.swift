//
//  LimitOffsetPageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Combine

// MARK: - LimitOffsetPageProvider

public protocol LimitOffsetPageProvider: PublisherPageProvider {
    
    // MARK: - Public properties
    
    var allItems: [T] { get set }
    
    var requestLimit: Int { get }
    
    /// Should be zero by initial state.
    var loadedPagesCount: Int { get set }
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int) -> AnyPublisher<Page<T>, Error>
}

// MARK: - LimitOffsetPageProvider + Default Implementation

public extension LimitOffsetPageProvider {
    
    // MARK: - Public properties
    
    var requestLimit: Int { 20 }
    
    var requestOffset: Int { loadedPagesCount * requestLimit }
    
    // MARK: - Public methods
    
    func getFirstPage() -> AnyPublisher<PageResult<T>, Error> {
        return getItems(limit: requestLimit, offset: requestOffset)
            .handleEvents(receiveOutput: { [weak self] (page) in
                self?.resetAllItems(page.items)
            })
            .map { [weak self] (page) -> PageResult<T> in
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            .eraseToAnyPublisher()
    }
    
    func getNextPage() -> AnyPublisher<PageResult<T>, Error> {
        return getItems(limit: requestLimit, offset: requestOffset)
            .handleEvents(receiveOutput: { [weak self] (page) in
                self?.appendNewItems(page.items)
            })
            .map { [weak self] (page) -> PageResult<T> in
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            .eraseToAnyPublisher()
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
