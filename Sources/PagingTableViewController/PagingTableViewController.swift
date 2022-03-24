//
//  PagingTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import UIKit

open class PagingTableViewController<Provider: PageProvider, SectionItem: Hashable, RowItem: Hashable>:
    LoadingTableViewController<SectionItem, RowItem> {
        
    open var pageProvider: Provider { fatalError("Page provider must be overriden") }
        
    private var isRequestedInitialItems = false
        
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isRequestedInitialItems == false {
            isRequestedInitialItems = true
            
            requestInitialItems()
        }
    }
    
    open override func pagingDidStartLoading(_ adapter: PagingAdapter) {
        super.pagingDidStartLoading(adapter)
        
        requestNextPageItems()
    }
    
    open override func refreshDidStartLoading(_ refreshControl: UIRefreshControl) {
        super.refreshDidStartLoading(refreshControl)
        
        requestRefreshItems()
    }
        
    open func requestInitialItems() {
        paginationAdapter.hide()
        
        pageProvider.getFirstPage { [weak self] result in
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
        
        startWaitingPage(isEnabled: pageResult.hasMore)
    }
    
    open func handleInitialError(_ error: Error) { }
        
    open func requestRefreshItems() {
        pageProvider.getFirstPage { [weak self] result in
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
        apply(newSnapshot, animating: false)
        
        startWaitingPage(isEnabled: pageResult.hasMore)
    }
    
    open func handleRefreshError(_ error: Error) {
        refreshControl.endRefreshing()
    }
        
    open func requestNextPageItems() {
        pageProvider.getNextPage { [weak self] result in
            switch result {
            case .success(let pageResult):
                self?.handlePagingItems(pageResult)
                
            case .failure(let error):
                self?.handlePagingError(error)
            }
        }
    }
    
    open func handlePagingItems(_ pageResult: PageResult<Provider.T>) {
        paginationAdapter.hide()
        
        let newSnapshot = map(newItems: pageResult.newItems, allItems: pageResult.allItems)
        apply(newSnapshot) { [weak self] in
            self?.startWaitingPage(isEnabled: pageResult.hasMore)
        }
    }
    
    open func handlePagingError(_ error: Error) { }
    
    open func map(
        newItems: [Provider.T],
        allItems: [Provider.T]
    ) -> NSDiffableDataSourceSnapshot<SectionItem, RowItem> {
        fatalError("Map should be overriden")
    }
        
    private func startWaitingPage(isEnabled: Bool) {
        paginationAdapter.isEnabled = isEnabled
        paginationAdapter.startWaiting()
    }
}
