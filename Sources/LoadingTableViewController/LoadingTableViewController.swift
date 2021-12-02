//
//  LoadingTableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 07.04.2021.
//

import UIKit
import Combine

// MARK: - LoadingTableViewController

/// LoadingTableViewController = TableViewController + UIRefreshControl with infinite scroll support. PagingAdapter takes care of the inifite scroll logic.

open class LoadingTableViewController<SectionItem: Hashable, RowItem: Hashable>: TableViewController<SectionItem, RowItem> {
    
    // MARK: - Public properties
    
    open var hasRefresh: Bool { false }
    open var hasPagination: Bool { false }
    
    open var pagingConfig: PagingConfig { .default }
    
    open lazy var paginationAdapter = PagingAdapter(scrollView: tableView, superView: view, config: pagingConfig)
    open lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Override methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        setupPaginationControl()
    }
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        paginationAdapter.updateOnScroll()
    }
    
    // MARK: - Public methods
    
    @objc open func refreshDidStartLoading(_ refreshControl: UIRefreshControl) { }
    
    open func pagingDidStartLoading(_ adapter: PagingAdapter) { }
    
    // MARK: - Private methods
    
    private func setupRefreshControl() {
        if hasRefresh {
            tableView.refreshControl = refreshControl
            tableView.refreshControl?.addTarget(self, action: #selector(Self.refreshDidStartLoading), for: .valueChanged)
        }
    }
    
    private func setupPaginationControl() {
        if hasPagination {
            paginationAdapter.isEnabled = true
            paginationAdapter.delegate = self
        }
    }
    
}

// MARK: - PaginationAdapterDelegate

extension LoadingTableViewController: PagingAdapterDelegate {
    
    public func pagingAdapterDidRequest(_ adapter: PagingAdapter) {
        pagingDidStartLoading(adapter)
    }
    
    public func pagingAdapterDidRetry(_ adapter: PagingAdapter) {
        pagingDidStartLoading(adapter)
    }
}
