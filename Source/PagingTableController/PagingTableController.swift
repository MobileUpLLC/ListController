//
//  PagingTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import UIKit


open class PagingTableController<Provider: PageProvider, SectionItem: Hashable, RowItem: Hashable>:
    LoadingTableController<SectionItem, RowItem> {
    
    // MARK: - Public properties
    
    open var pageProvider: Provider { fatalError() }
    
    // MARK: - Override methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        requestInitialItems()
    }
    
    open override func pagingDidStartLoading(_ adapter: PagingAdapter) {
        super.pagingDidStartLoading(adapter)
        
        requestNextPageItems()
    }
    
    open override func refreshDidStartLoading(_ refreshControl: UIRefreshControl) {
        super.refreshDidStartLoading(refreshControl)
        
        requestRefreshItems()
    }
    
    // MARK: - Public methods
    
    // MARK: Initial Items
    
    open func requestInitialItems() {
        pageProvider.getFirstPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handleInitialItems(pageResult)
                
            case .failure(let error):
                self?.handleInitialError(error)
            }
        }
    }
    
    open func handleInitialItems(_ pageResult: PageResult<Provider.T>) {
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        apply(newSnapshot, animating: false)
        
        paginationAdapter.isEnabled = pageResult.hasMore
    }
    
    open func handleInitialError(_ error: Error) { }
    
    // MARK: Refresh Items
    
    open func requestRefreshItems() {
        pageProvider.getFirstPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handleRefreshItems(pageResult)
                
            case .failure(let error):
                self?.handleRefreshError(error)
            }
        }
    }
    
    open func handleRefreshItems(_ pageResult: PageResult<Provider.T>) {
        refreshControl.endRefreshing()
        
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        apply(newSnapshot)
        
        paginationAdapter.isEnabled = pageResult.hasMore
    }
    
    open func handleRefreshError(_ error: Error) {
        refreshControl.endRefreshing()
    }
    
    // MARK: Next Page Items
    
    open func requestNextPageItems() {
        pageProvider.getNextPage { [weak self] (result) in
            switch result {
            case .success(let pageResult):
                self?.handlePagingItems(pageResult)
                
            case .failure(let error):
                self?.handlePagingError(error)
            }
        }
    }
    
    open func handlePagingItems(_ pageResult: PageResult<Provider.T>) {
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        
        apply(newSnapshot) { [paginationAdapter] in
            paginationAdapter.startWaiting()
            paginationAdapter.isEnabled = pageResult.hasMore
        }
    }
    
    open func handlePagingError(_ error: Error) {
        paginationAdapter.showMessage("Ooops :(")
    }
    
    open func map(
        newItems: [Provider.T],
        allItems: [Provider.T]
    ) -> NSDiffableDataSourceSnapshot<SectionItem, RowItem> {
        fatalError()
    }
}
