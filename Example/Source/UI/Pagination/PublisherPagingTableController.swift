//
//  PublisherPagingTableController.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 27.12.2021.
//

import UIKit
import ListController

// MARK: - PublisherPagingTableController

class PublisherPagingTableController: CustomPagingTableViewController<PublisherSeasInteractor, Int, String> {
    
    // MARK: - Override properties

    override var pageProvider: PublisherSeasInteractor { interactor }
    
    // MARK: - Private properties
    
    private let interactor = PublisherSeasInteractor()
    
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
