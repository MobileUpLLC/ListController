//
//  Example.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit

struct Example {
    
    let name: String
    let controller: UIViewController.Type
}

extension Example: Hashable {
    
    static func == (lhs: Example, rhs: Example) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
