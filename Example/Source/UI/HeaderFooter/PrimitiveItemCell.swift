//
//  PrimitiveItemCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import UIKit
import ListController

// MARK: - PrimitiveItemCell

class PrimitiveItemCell: UITableViewCell {}

// MARK: - Configurable

extension PrimitiveItemCell: Configurable {

    // MARK: - Public methods

    func setup(with item: HeaderFooterItem) {
        switch item {
        case .item(let primitive):
            textLabel?.text = primitive.id
        default:
            break
        }
    }
}
