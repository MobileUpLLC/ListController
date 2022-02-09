//
//  TableViewDiffableDataSource.swift
//  ListController
//
//  Created by Vladislav Grokhotov on 09.02.2022.
//

import UIKit

/// It is a class for avoiding Xcode 12 SDK bug when cell swipes provided by trailing- and leadingSwipeActionsConfigurationForRowAt don't work
open class TableViewDiffableDataSource<SectionItem: Hashable, RowItem: Hashable>:
    UITableViewDiffableDataSource<SectionItem, RowItem> {
    
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
