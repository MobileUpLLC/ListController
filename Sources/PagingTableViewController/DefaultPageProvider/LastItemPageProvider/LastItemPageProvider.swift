//
//  LastItemPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation

public protocol LastItemPageProvider: PageProvider, AnyObject {
        
    var allItems: [T] { get set }
        
    func getItems(last: T?, completion: @escaping (Result<Page<T>, Error>) -> Void)
}

public extension LastItemPageProvider {
        
    func getFirstPage(_ completion: @escaping Completion) {
        getItems(last: nil) { [weak self] page in
            let pageResult = page.map { [weak self] (page) -> PageResult<T> in
                self?.resetAllItems(page.items)
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            completion(pageResult)
        }
    }
    
    func getNextPage(_ completion: @escaping Completion) {
        getItems(last: allItems.last) { [weak self] page in
            let pageResult = page.map { [weak self] (page) -> PageResult<T> in
                self?.appendNewItems(page.items)
                return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
            }
            completion(pageResult)
        }
    }
    
    func appendNewItems(_ items: [T]) {
        allItems += items
    }
    
    func resetAllItems(_ items: [T]) {
        allItems = items
    }
}
