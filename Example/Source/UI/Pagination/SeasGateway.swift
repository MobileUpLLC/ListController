//
//  SeasGateway.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation

// MARK: - SeasGateway

final class SeasGateway {
    
    enum Error: Swift.Error {
        
        case unknown
    }

    // MARK: - Public methods

    func getExamples(
        limit: Int,
        offset: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if offset == 0 || Int.random(in: 0..<10) < 5 {
                let endIndex = min(offset + limit, seas.count)
                completion(Result.success(Array(seas[offset..<endIndex])))
            } else {
                completion(Result.failure(Error.unknown))
            }
        }
    }
}
