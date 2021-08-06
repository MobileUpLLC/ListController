//
//  SearchViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - SearchViewController

class SearchViewController: TableController<Int, String> {
    
    // MARK: - Override properties
    
    override var tableView: UITableView { searchTableView }
    
    // MARK: - Private properties
    
    private let searchTableView = UITableView(frame: .zero, style: .grouped)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let items: [String] = seas
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        setupTable(with: SearchCell.self)
        setupSearchController()

        update(with: items)
    }

    // MARK: - Private methods

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        navigationItem.searchController = searchController
    }

    private func update(with items: [String], animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        apply(snapshot, animating: animated)
    }
}

// MARK: - SearchViewController

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard
            let filter = searchController.searchBar.text,
            filter.isEmpty == false
        else {
            return update(with: seas, animated: true)
        }

        let filteredWords = seas.filter { $0.lowercased().contains(filter.lowercased()) }

        update(with: filteredWords, animated: true)
    }
}
