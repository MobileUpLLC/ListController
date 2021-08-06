//
//  TableController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import Foundation
import ListController

// MARK: - TableController

extension TableController {

    // MARK: - Public methods

    func setupTable(with cellClass: AnyClass) {
        view.addSubview(tableView)

        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }

        tableView.register(cellClass, forCellReuseIdentifier: defaultCellReuseIdentifier)
    }
}
