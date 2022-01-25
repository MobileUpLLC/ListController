//
//  PublisherSeasInteractor.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation
import ListController
import Combine

// MARK: - SeasInteractor

class PublisherSeasInteractor: PublisherLimitOffsetPageProvider {
    
    // MARK: - Types
    
    typealias T = String
    
    // MARK: - Public properties
    
    var allItems: [String] = []
    var loadedPagesCount: Int = 0
    var subscribes = Set<AnyCancellable>()
    var isDataEmpty: Bool { allItems.isEmpty }

    // MARK: - Private properties
    
    private let gateway = PublisherSeasGateway()
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int) -> AnyPublisher<Page<String>, Error> {
        return gateway.getExamples(limit: limit, offset: offset)
            .map {
                Page(items: $0, hasMore: $0.count == limit)
            }
            .eraseToAnyPublisher()
    }
}
