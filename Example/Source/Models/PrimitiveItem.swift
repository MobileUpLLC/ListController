//
//  PrimitiveItem.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import Foundation

// MARK: - PrimitiveItem

struct PrimitiveItem: Identifiable, Hashable {

    // MARK: Public properties

    var id: String { String(describing: value) }
    let value: CustomStringConvertible

    // MARK: - Public methods

    static func == (lhs: PrimitiveItem, rhs: PrimitiveItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
