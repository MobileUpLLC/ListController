//
//  CustomPagingTableViewController.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 27.12.2021.
//

import UIKit
import ListController

class CustomPagingTableViewController<Provider: PageProvider, SectionItem: Hashable, RowItem: Hashable>:
    PagingTableViewController<Provider, SectionItem, RowItem> {
        
    override var tableView: UITableView { paginationTableView }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override var rowAnimation: UITableView.RowAnimation { .fade }
    override var hasRefresh: Bool { true }
    override var hasPagination: Bool { true }
        
    private let paginationTableView = UITableView(frame: .zero, style: .grouped)
    private var loadingView = UIActivityIndicatorView(
        frame: .init(x: 0, y: 0, width: 40, height: 40)
    )
    private var isLoading = false { didSet { updateLoadingIndicator() } }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pagination"
        
        setupLoadingView()
        setupPaginationTableView()
        tableView.register(SearchCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)
    }
        
    override func requestInitialItems() {
        super.requestInitialItems()
        
        isLoading = true
        tableView.isHidden = true
    }
    
    override func handleInitialItems(_ pageResult: PageResult<Provider.T>) {
        super.handleInitialItems(pageResult)
        
        isLoading = false
        tableView.isHidden = false
    }
    
    override func handleInitialError(_ error: Error) {
        super.handleInitialError(error)
        
        handleError(error)
    }
        
    override func handleRefreshError(_ error: Error) {
        super.handleRefreshError(error)
        
        handleError(error)
    }
        
    override func handlePagingError(_ error: Error) {
        super.handlePagingError(error)
        
        paginationAdapter.showMessage("Error: \(error)")
    }
        
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.hidesWhenStopped = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.bringSubviewToFront(loadingView)
    }
    
    private func updateLoadingIndicator() {
        if isLoading == true {
            loadingView.isHidden = false
            loadingView.startAnimating()
        } else {
            loadingView.isHidden = true
            loadingView.stopAnimating()
        }
    }
    
    private func handleError(_ error: Error) {
        isLoading = false
        
        UIView.animateKeyframes(withDuration: 1, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.view.backgroundColor = .red
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.view.backgroundColor = .white
            }
        }
    }
    
    private func setupPaginationTableView() {
        setupTable()
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.tableFooterView = UIView()
    }
}
