//
//  LastItemPageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Combine

// MARK: - LastItemPageProvider

protocol LastItemPageProvider: PublisherPageProvider {
    
    // MARK: - Public properties
    
    var allItems: [T] { get set }
    
    // MARK: - Public methods
    
    func getItems(last: T?) -> AnyPublisher<Page<T>, Error>
}

// MARK: - LastItemPageProvider + Default Implementation

extension LastItemPageProvider {
    
    // MARK: - Public methods
    
    func getFirstPage() -> AnyPublisher<PageResult<T>, Error> {
        return getItems(last: nil)
            .handleEvents(receiveOutput: { [weak self] (page) in
                self?.resetAllItems(page.items)
            })
            .map { [weak self] (page) -> PageResult<T> in
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            .eraseToAnyPublisher()
    }
    
    func getNextPage() -> AnyPublisher<PageResult<T>, Error> {
        return getItems(last: allItems.last)
            .handleEvents(receiveOutput: { [weak self] (page) in
                self?.appendNewItems(page.items)
            })
            .map { [weak self] (page) -> PageResult<T> in
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            .eraseToAnyPublisher()
    }
    
    func appendNewItems(_ items: [T]) {
        allItems += items
    }
    
    func resetAllItems(_ items: [T]) {
        allItems = items
    }
}
