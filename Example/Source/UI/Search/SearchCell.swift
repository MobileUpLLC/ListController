//
//  SearchCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - SearchCell

class SearchCell: UITableViewCell {}

// MARK: - Configurable

extension SearchCell: Configurable {

    // MARK: - Public methods

    func setup(with item: String) {
        textLabel?.text = item
    }
}
