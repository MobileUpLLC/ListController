//
//  CollectionInteractor.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import Foundation

class CollectionInteractor {
    
    private let gateway = CollectionGateway()
    
    func getSeas(completion: @escaping ([String]) -> Void) {
        gateway.getSeas(completion: completion)
    }
}
