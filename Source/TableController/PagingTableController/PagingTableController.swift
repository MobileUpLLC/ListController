//
//  PagingTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import UIKit


public class PagingTableController<Provider: PageProvider, SectionItem: Hashable, RowItem: Hashable>:
    LoadingTableController<SectionItem, RowItem> {
    
    // MARK: - Public properties
    
    var pageProvider: Provider { fatalError() }
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        requestInitialItems()
    }
    
    public override func pagingDidStartLoading(_ adapter: PagingAdapter) {
        super.pagingDidStartLoading(adapter)
        
        requestNextPageItems()
    }
    
    public override func refreshDidStartLoading(_ refreshControl: UIRefreshControl) {
        super.refreshDidStartLoading(refreshControl)
        
        requestRefreshItems()
    }
    
    // MARK: - Public methods
    
    // MARK: Initial Items
    
    func requestInitialItems() {
        pageProvider.getFirstPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handleInitialItems(pageResult)
                
            case .failure(let error):
                self?.handleInitialError(error)
            }
        }
    }
    
    func handleInitialItems(_ pageResult: PageResult<Provider.T>) {
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        apply(newSnapshot, animating: false)
        
        paginationAdapter.isEnabled = pageResult.hasMore
    }
    
    func handleInitialError(_ error: Error) { }
    
    // MARK: Refresh Items
    
    func requestRefreshItems() {
        pageProvider.getFirstPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handleRefreshItems(pageResult)
                
            case .failure(let error):
                self?.handleRefreshError(error)
            }
        }
    }
    
    func handleRefreshItems(_ pageResult: PageResult<Provider.T>) {
        refreshControl.endRefreshing()
        
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        apply(newSnapshot)
        
        paginationAdapter.isEnabled = pageResult.hasMore
    }
    
    func handleRefreshError(_ error: Error) {
        refreshControl.endRefreshing()
    }
    
    // MARK: Next Page Items
    
    func requestNextPageItems() {
        pageProvider.getNextPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handlePagingItems(pageResult)
                
            case .failure(let error):
                self?.handlePagingError(error)
            }
        }
    }
    
    func handlePagingItems(_ pageResult: PageResult<Provider.T>) {
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        
        apply(newSnapshot) { [paginationAdapter] in
            paginationAdapter.startWaiting()
            paginationAdapter.isEnabled = pageResult.hasMore
        }
    }
    
    func handlePagingError(_ error: Error) {
        paginationAdapter.showMessage("Ooops :(")
    }
    
    func map(
        newItems: [Provider.T],
        allItems: [Provider.T]
    ) -> NSDiffableDataSourceSnapshot<SectionItem, RowItem> {
        fatalError()
    }
}
