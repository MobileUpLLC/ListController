//
//  BaseTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

open class BaseTableViewController<SectionItem: Hashable, RowItem: Hashable>:
    BaseListViewController<SectionItem, RowItem> {
    
    open var tableView: UITableView { fatalError("Table view must be overriden") }
    open var rowAnimation: UITableView.RowAnimation { .automatic }

    public lazy var dataSource = UITableViewDiffableDataSource<SectionItem, RowItem>(
        tableView: tableView,
        cellProvider: { [weak self] _, indexPath, item -> UITableViewCell? in
            return self?.dequeueReusableCell(for: item, at: indexPath)
        }
    )

    public var snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem> { dataSource.snapshot() }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.defaultRowAnimation = rowAnimation
    }
    
    /// Important: you first need to add sections to the snapshot, and then items. Otherwise crash
    open func apply(
        _ snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem>,
        animating: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        dataSource.apply(snapshot, animatingDifferences: animating, completion: completion)
    }

    open func dequeueReusableCell(for item: RowItem, at indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = cellReuseIdentifier(for: item, at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let configurableItem = prepareRowItem(item, at: indexPath)
        
        setupConfigurableView(cell, with: configurableItem)
        
        return cell
    }
    
    open func prepareRowItem(_ item: RowItem, at indexPath: IndexPath) -> Any {
        return item
    }
}
