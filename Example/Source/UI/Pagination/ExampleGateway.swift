//
//  ExampleGateway.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import Foundation

// MARK: - StringPage

struct StringPage {
    
    // MARK: - Public properties
    
    public let contents: [String]
    public let hasMore: Bool
}

// MARK: - ExampleGateway

final class ExampleGateway {

    // MARK: - Public methods

    func getExamples(
        page: Int = 1,
        pageSize: Int = 20,
        completion: @escaping (Result<StringPage, Error>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let startIndex = (page-1) * pageSize
            var endIndex = page * pageSize
            if endIndex > seas.count {
                endIndex = seas.count
            }
            completion(
                Result.success(
                    StringPage(
                        contents: Array(seas[startIndex..<endIndex]),
                        hasMore: endIndex != seas.count
                    )
                )
            )
        }
    }
}
