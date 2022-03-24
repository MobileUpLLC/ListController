//
//  TableController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

extension TableViewController {
    
    func setupTable(separatorStyle: UITableViewCell.SeparatorStyle = .singleLine) {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground

        tableView.estimatedSectionHeaderHeight = .leastNormalMagnitude
        tableView.estimatedSectionFooterHeight = 0

        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = separatorStyle

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension TableViewController where SectionItem == Int {
    
    func apply(items: [RowItem], animated: Bool = false) {
        var snapshot = snapshot

        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        apply(snapshot, animating: animated)
    }
}
