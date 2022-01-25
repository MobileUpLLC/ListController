//
//  PrimitiveItemCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import UIKit
import ListController

class PrimitiveItemCell: UITableViewCell {}

extension PrimitiveItemCell: Configurable {
    
    func setup(with item: HeaderFooterItem) {
        switch item {
        case .item(let primitive):
            textLabel?.text = primitive.id
        default:
            break
        }
    }
}
