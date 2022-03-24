//
//  SearchViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

class SearchViewController: TableViewController<Int, String> {
        
    override var tableView: UITableView { searchTableView }
        
    private let searchTableView = UITableView(frame: .zero, style: .grouped)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let items: [String] = seas
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        setupTable()
        tableView.register(SearchCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)

        setupSearchController()

        apply(items: items)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
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
