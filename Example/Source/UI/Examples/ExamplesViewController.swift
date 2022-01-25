//
//  ExamplesViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

class ExamplesViewController: TableViewController<Int, Example> {
    
    override var tableView: UITableView { examplesTableView }
    
    private let examplesTableView = UITableView(frame: .zero, style: .grouped)

    private let items: [Example] = [
        Example(name: "Search", controller: SearchViewController.self),
        Example(name: "HeaderFooter", controller: HeaderFooterViewController.self),
        Example(name: "Pagination", controller: PagingTableController.self),
        Example(name: "Pagination with publisher", controller: PublisherPagingTableController.self),
        Example(name: "Pagination with TabBar", controller: TabBarPagingTableController.self)
    ]
    
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
