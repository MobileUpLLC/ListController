//
//  PublisherPageProvider.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Combine

// MARK: - PublisherPageProvider

protocol PublisherPageProvider: PageProvider, AnyObject {
    
    // MARK: - Public properties
    
    var subscribes: Set<AnyCancellable> { get set }
    
    // MARK: - Public methods
    
    func getFirstPage() -> AnyPublisher<PageResult<T>, Error>
    func getNextPage() -> AnyPublisher<PageResult<T>, Error>
}

// MARK: - PageProvider Implementation

extension PublisherPageProvider {
    
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

// MARK: - AnyPublisher + Sink On Closure

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
