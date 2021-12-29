//
//  PagingTableController.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import UIKit
import ListController

// MARK: - PagingTableController

class PagingTableController: CustomPagingTableViewController<SeasInteractor, Int, String> {
    
    // MARK: - Override properties

    override var pageProvider: SeasInteractor { interactor }
    
    // MARK: - Private properties
    
    private let interactor = SeasInteractor()
    
    // MARK: - Override methods
    
    override func map(
        newItems: [String],
        allItems: [String]
    ) -> NSDiffableDataSourceSnapshot<Int, String> {
        var currentSnapshot = snapshot
        
        if newItems.count == allItems.count {
            currentSnapshot.deleteAllItems()
            currentSnapshot.appendSections([0])
        }
        
        currentSnapshot.appendItems(newItems, toSection: 0)
        
        return currentSnapshot
    }
}
