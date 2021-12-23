//
//  SeasGateway.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation

// MARK: - SeasGateway

final class SeasGateway {

    // MARK: - Public methods

    func getExamples(
        limit: Int,
        offset: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var endIndex = offset + limit
            if endIndex > seas.count {
                endIndex = seas.count
            }
            completion(Result.success(Array(seas[offset..<endIndex])))
        }
    }
}
