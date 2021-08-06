//
//  ExamplesViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController
import SnapKit

// MARK: - ExamplesViewController

class ExamplesViewController: TableController<Int, Example> {

    // MARK: - Override properties

    override var tableView: UITableView { examplesTableView }

    // MARK: - Private properties

    private let examplesTableView = UITableView(frame: .zero, style: .grouped)

    private let items: [Example] = [
        Example(name: "Search", controller: SearchViewController.self),
    ]

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Examples"

        setupTable(with: ExampleCell.self)
        applyItems()
    }

    override func cellDidSelect(for item: Example, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        navigationController?.pushViewController(item.controller.init(), animated: true)
    }

    // MARK: - Private methods

    private func applyItems() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Example>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        apply(snapshot)
    }
}
