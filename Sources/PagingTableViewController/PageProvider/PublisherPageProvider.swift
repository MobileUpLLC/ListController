//
//  PublisherPageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Combine

public protocol PublisherPageProvider: PageProvider, AnyObject {
        
    var subscribes: Set<AnyCancellable> { get set }
        
    func getFirstPage() -> AnyPublisher<PageResult<T>, Error>
    func getNextPage() -> AnyPublisher<PageResult<T>, Error>
}

public extension PublisherPageProvider {
    
    func getFirstPage(_ completion: @escaping (Result<PageResult<T>, Error>) -> Void) {
        getFirstPage()
            .sinkOn(completion)
            .store(in: &subscribes)
    }
    
    func getNextPage(_ completion: @escaping (Result<PageResult<T>, Error>) -> Void) {
        getNextPage()
            .sinkOn(completion)
            .store(in: &subscribes)
    }
}

extension AnyPublisher {
    
    func sinkOn(_ completion: @escaping (Result<Self.Output, Self.Failure>) -> Void) -> AnyCancellable {
        return sink { (result) in
            switch result {
            case .finished:
                break
            case .failure(let error):
                completion(.failure(error))
            }
        } receiveValue: { (value) in
            completion(.success(value))
        }
    }
}
