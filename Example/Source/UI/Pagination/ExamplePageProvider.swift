//
//  ExamplePageProvider.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation
import ListController

// MARK: - ExamplePageProvider

class ExamplePageProvider: LastPageProvider {
    
    // MARK: - Types
    
    typealias T = String
    
    // MARK: - Public properties
    
    var allItems: [String] = []
    var loadedPagesCount: Int = 0
    var isDataEmpty: Bool { allItems.isEmpty }

    // MARK: - Private properties
    
    private let gateway = ExampleGateway()
    
    // MARK: - Public methods
    
    func getItems(pageIndex: Int, pageSize: Int, completion: @escaping (Result<Page<T>, Error>) -> Void) {
        gateway.getExamples(page: pageIndex, pageSize: pageSize) { result in
            let page = result
                .map { Page(items: $0.contents, hasMore: $0.hasMore) }
                .mapError { $0 as Error }
            completion(page)
        }
    }
}
