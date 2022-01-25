//
//  ExamplesViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - ExamplesViewController

class ExamplesViewController: TableViewController<Int, Example> {

    // MARK: - Override properties

    override var tableView: UITableView { examplesTableView }

    // MARK: - Private properties

    private let examplesTableView = UITableView(frame: .zero, style: .grouped)

    private let items: [Example] = [
        Example(name: "Search", controller: SearchViewController.self),
        Example(name: "HeaderFooter", controller: HeaderFooterViewController.self),
        Example(name: "Pagination", controller: PagingTableController.self),
        Example(name: "Pagination with publisher", controller: PublisherPagingTableController.self),
        Example(name: "Pagination with TabBar", controller: TabBarPagingTableController.self)
    ]

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Examples"

        setupTable()
        tableView.register(ExampleCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)

        apply(items: items)
    }

    override func cellDidSelect(for item: Example, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        navigationController?.pushViewController(item.controller.init(), animated: true)
    }
}
