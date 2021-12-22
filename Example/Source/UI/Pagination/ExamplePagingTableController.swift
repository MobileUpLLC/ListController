//
//  ExamplePagingTableController.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import UIKit
import ListController

// MARK: - ExamplePagingTableController

class ExamplePagingTableController: PagingTableViewController<ExamplePageProvider, Int, String> {
    
    // MARK: - Override properties
    
    override var tableView: UITableView { paginationTableView }
    override var pageProvider: ExamplePageProvider { interactor }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override var rowAnimation: UITableView.RowAnimation { .fade }
    override var hasRefresh: Bool { true }
    override var hasPagination: Bool { true }
    
    // MARK: - Private properties
    
    private let interactor = ExamplePageProvider()
    private let paginationTableView = UITableView(frame: .zero, style: .grouped)
    private var loadingView: UIActivityIndicatorView = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 40, height: 40))
    private var isLoading: Bool = false { didSet { updateLoadingIndicator() } }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pagination"
        
        setupLoadingView()
        setupTable()
        tableView.register(SearchCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)
    }
    
    // MARK: Initial Items
    
    override func requestInitialItems() {
        super.requestInitialItems()
        
        isLoading = true
        tableView.isHidden = true
    }
    
    override func handleInitialItems(_ pageResult: PageResult<ExamplePageProvider.T>) {
        super.handleInitialItems(pageResult)
        
        isLoading = false
        tableView.isHidden = false
    }
    
    override func handleInitialError(_ error: Error) {
        super.handleInitialError(error)
        
        handleError(error)
    }
    
    // MARK: Refresh Items
    
    override func handleRefreshError(_ error: Error) {
        super.handleRefreshError(error)
        
        handleError(error)
    }
 
    // MARK: Next Page Items
    
    override func handlePagingError(_ error: Error) {
        super.handlePagingError(error)
        
        handleError(error)
    }
    
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
    
    // MARK: - Private methods
    
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
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.view.backgroundColor = .red
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.view.backgroundColor = .white
            })
        }
    }

}
