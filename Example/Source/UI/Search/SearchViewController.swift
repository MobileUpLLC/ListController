//
//  SearchViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - SearchViewController

class SearchViewController: TableViewController<Int, String> {
    
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
        
        setupTable()
        tableView.register(SearchCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)

        setupSearchController()

        apply(items: items)
    }

    // MARK: - Private methods

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

// MARK: - SearchViewController

extension SearchViewController: UISearchResultsUpdating {

    // MARK: - Public methods

    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchText = searchController.searchBar.text,
            searchText.isEmpty == false
        else {
            apply(items: items, animated: true)
            return
        }

        let filteredWords = items.filter { $0.lowercased().contains(searchText.lowercased()) }

        apply(items: filteredWords, animated: true)
    }
}
