//
//  PublisherLimitOffsetPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Combine

// MARK: - PublisherLimitOffsetPageProvider

public protocol PublisherLimitOffsetPageProvider: LimitOffsetPageProvider {
    
    // MARK: - Public properties
    
    var subscribes: Set<AnyCancellable> { get set }
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int) -> AnyPublisher<Page<T>, Error>
}

// MARK: - PublisherLimitOffsetPageProvider + Default Implementation

public extension PublisherLimitOffsetPageProvider {
    
    // MARK: - Public methods
    
    func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<T>, Error>) -> Void) {
        getItems(limit: limit, offset: offset)
            .sinkOn(completion)
            .store(in: &subscribes)
    }
}
