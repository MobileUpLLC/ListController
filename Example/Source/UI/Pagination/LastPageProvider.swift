//
//  LastPageProvider.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation
import ListController

 // MARK: - LastPageProvider

 protocol LastPageProvider: PageProvider, AnyObject {

     // MARK: - Public properties
     
     var allItems: [T] { get set }

     var requestLimit: Int { get }

     /// Should be zero by initial state.
     var loadedPagesCount: Int { get set }

     // MARK: - Public methods
     
     func getItems(pageIndex: Int, pageSize: Int, completion: @escaping (Result<Page<T>, Error>) -> Void)
 }

 // MARK: - DefaultPageProvider + Default Implementation

 extension LastPageProvider {

     // MARK: - Public properties
     
     var requestLimit: Int { 30 }

     // MARK: - Public methods
     
     func getFirstPage(_ completion: @escaping Completion) {
         getItems(pageIndex: 1, pageSize: requestLimit) { [weak self] page in
             let pageResult = page.map { [weak self] (page) -> PageResult<T> in
                 self?.resetAllItems(page.items)
                 return PageResult(newItems: page.items, allItems: self?.allItems ?? [], hasMore: page.hasMore)
             }
             completion(pageResult)
         }
     }

     func getNextPage(_ completion: @escaping Completion) {
         getItems(pageIndex: loadedPagesCount + 1, pageSize: requestLimit) { [weak self] page in
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
