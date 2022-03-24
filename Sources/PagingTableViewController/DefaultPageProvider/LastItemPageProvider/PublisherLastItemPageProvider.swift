//
//  PublisherLastItemPageProvider.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Combine

public protocol PublisherLastItemPageProvider: LastItemPageProvider {
        
    var subscribes: Set<AnyCancellable> { get set }
        
    func getItems(last: T?) -> AnyPublisher<Page<T>, Error>
}

public extension PublisherLastItemPageProvider {
        
    func getItems(last: T?, completion: @escaping (Result<Page<T>, Error>) -> Void) {
        getItems(last: last) 
            .sinkOn(completion)
            .store(in: &subscribes)
    }
}
