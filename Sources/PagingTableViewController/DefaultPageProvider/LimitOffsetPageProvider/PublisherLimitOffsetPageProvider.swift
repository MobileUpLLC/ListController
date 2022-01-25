//
//  PublisherLimitOffsetPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Combine

public protocol PublisherLimitOffsetPageProvider: LimitOffsetPageProvider {
        
    var subscribes: Set<AnyCancellable> { get set }
        
    func getItems(limit: Int, offset: Int) -> AnyPublisher<Page<T>, Error>
}

public extension PublisherLimitOffsetPageProvider {
        
    func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<T>, Error>) -> Void) {
        getItems(limit: limit, offset: offset)
            .sinkOn(completion)
            .store(in: &subscribes)
    }
}
