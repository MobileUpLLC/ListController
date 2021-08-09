//
//  TableController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - TableController

extension TableController {

    // MARK: - Public methods

    func setupTable(separatorStyle: UITableViewCell.SeparatorStyle = .singleLine) {
        view.addSubview(tableView)

        tableView.estimatedSectionHeaderHeight = .leastNormalMagnitude
        tableView.estimatedSectionFooterHeight = 0

        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = separatorStyle

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
}

// MARK: - TableController

extension TableController where SectionItem == Int {

    // MARK: - Public methods

    func apply(items: [RowItem], animated: Bool = false) {
        var snapshot = snapshot

        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        apply(snapshot, animating: animated)
    }
}
