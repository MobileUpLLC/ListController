//
//  CollectionGateway.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import Foundation

class CollectionGateway {
    
    func getSeas(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(seas)
        }
    }
}
