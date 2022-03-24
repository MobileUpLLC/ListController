//
//  PublisherSeasInteractor.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation
import ListController
import Combine

class PublisherSeasInteractor: PublisherLimitOffsetPageProvider {
        
    typealias T = String
        
    var allItems: [String] = []
    var loadedPagesCount: Int = 0
    var subscribes = Set<AnyCancellable>()
    var isDataEmpty: Bool { allItems.isEmpty }
        
    private let gateway = PublisherSeasGateway()
        
    func getItems(limit: Int, offset: Int) -> AnyPublisher<Page<String>, Error> {
        return gateway.getExamples(limit: limit, offset: offset)
            .map {
                Page(items: $0, hasMore: $0.count == limit)
            }
            .eraseToAnyPublisher()
    }
}
