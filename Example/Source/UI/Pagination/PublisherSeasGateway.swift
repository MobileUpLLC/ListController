//
//  PublisherSeasGateway.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 24.12.2021.
//

import Foundation
import Combine

final class PublisherSeasGateway {
    
    func getExamples(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[String], Error> {
        let endIndex = min(offset + limit, seas.count)
        
        return Future { promise in
            promise(.success(Array(seas[offset..<endIndex])))
        }
        .delay(for: .seconds(1), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
