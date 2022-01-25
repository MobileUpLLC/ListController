//
//  PrimitiveItem.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import Foundation

struct PrimitiveItem: Identifiable, Hashable {
    
    var id: String { String(describing: value) }
    let value: CustomStringConvertible
    
    static func == (lhs: PrimitiveItem, rhs: PrimitiveItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
