//
//  PublisherLastItemPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//


import Combine

// MARK: - PublisherLastItemPageProvider

public protocol PublisherLastItemPageProvider: LastItemPageProvider {
    
    // MARK: - Public properties
    
    var subscribes: Set<AnyCancellable> { get set }
    
    // MARK: - Public methods
    
    func getItems(last: T?) -> AnyPublisher<Page<T>, Error>
}

// MARK: - PublisherLastItemPageProvider + Default Implementation

public extension PublisherLastItemPageProvider {
    
    // MARK: - Public methods
    
    func getItems(last: T?, completion: @escaping (Result<Page<T>, Error>) -> Void) {
        getItems(last: last) 
            .sinkOn(completion)
            .store(in: &subscribes)
    }
}

