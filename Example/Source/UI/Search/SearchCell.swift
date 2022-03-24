//
//  SearchCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

class SearchCell: UITableViewCell {}

extension SearchCell: Configurable {
    
    func setup(with item: String) {
        textLabel?.text = item
    }
}
