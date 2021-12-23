//
//  PublisherSeasGateway.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation
import Combine

// MARK: - SeasGateway

final class PublisherSeasGateway {

    // MARK: - Public methods

    func getExamples(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[String], Error> {
        var endIndex = offset + limit
        if endIndex > seas.count {
            endIndex = seas.count
        }
        
        return Array(seas[offset..<endIndex])
            .publisher
            .collect()
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
