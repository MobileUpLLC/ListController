//
//  Example.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit

// MARK: - Example

struct Example {

    // MARK: - Public properties

    let name: String
    let controller: UIViewController.Type
}

// MARK: - Hashable

extension Example: Hashable {

    // MARK: - Public methods

    static func == (lhs: Example, rhs: Example) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
