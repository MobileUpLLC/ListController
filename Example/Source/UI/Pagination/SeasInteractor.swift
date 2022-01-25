//
//  SeasInteractor.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation
import ListController

class SeasInteractor: LimitOffsetPageProvider {    
        
    typealias T = String
        
    var allItems: [String] = []
    var loadedPagesCount: Int = 0
    var isDataEmpty: Bool { allItems.isEmpty }
        
    private let gateway = SeasGateway()
        
    func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<String>, Error>) -> Void) {
        gateway.getExamples(limit: limit, offset: offset) { result in
            let page = result
                .map { Page(items: $0, hasMore: $0.count == limit) }
                .mapError { $0 as Error }
            completion(page)
        }
    }
}
