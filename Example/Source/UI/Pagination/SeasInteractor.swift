//
//  SeasInteractor.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation
import ListController

// MARK: - SeasInteractor

class SeasInteractor: LimitOffsetPageProvider {    
    
    // MARK: - Types
    
    typealias T = String
    
    // MARK: - Public properties
    
    var allItems: [String] = []
    var loadedPagesCount: Int = 0
    var isDataEmpty: Bool { allItems.isEmpty }

    // MARK: - Private properties
    
    private let gateway = SeasGateway()
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<String>, Error>) -> Void) {
        gateway.getExamples(limit: limit, offset: offset) { result in
            let page = result
                .map { Page(items: $0, hasMore: $0.count == limit) }
                .mapError { $0 as Error }
            completion(page)
        }
    }
}
