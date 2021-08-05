//
//  BaseTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

// MARK: - BaseTableController

open class BaseTableController<SectionItem: Hashable, RowItem: Hashable>: BaseListController<SectionItem, RowItem> {
    
    // MARK: - Public properties
    
    open var tableView: UITableView { fatalError() }
    open var rowAnimation: UITableView.RowAnimation { .automatic }
    
    lazy var dataSource = UITableViewDiffableDataSource<SectionItem, RowItem>(
        tableView: tableView,
        cellProvider: { [weak self] (tableView, indexPath, item) -> UITableViewCell? in
            return self?.dequeueReusableCell(for: item, at: indexPath)
        }
    )
    
    public var snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem> { dataSource.snapshot() }
    
    // MARK: - Override methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.defaultRowAnimation = rowAnimation
    }
    
    // MARK: - Public methods
    
    /// Важно: в снепшот сначала нужно добавить секции, а потом айтемы. Иначе креш
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
        
        setupConfigurableView(cell, with: item)
        
        return cell
    }
}
