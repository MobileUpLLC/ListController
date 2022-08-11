//
//  BaseLoadingCollectionViewController.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import UIKit
import ListController

class BaseLoadingCollectionViewController<SectionItem: Hashable, RowItem: Hashable>:
    ListController.CollectionViewController<SectionItem, RowItem> {

    var hasRefresh: Bool { false }

    lazy var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
    }

    @objc func refreshDidStartLoading(_ refreshControl: UIRefreshControl) { }

    private func setupRefreshControl() {
        if hasRefresh {
            collectionView.refreshControl = refreshControl
            collectionView.refreshControl?.tintColor = .black
            
            collectionView.refreshControl?.addTarget(
                self,
                action: #selector(Self.refreshDidStartLoading),
                for: .valueChanged
            )
        }
    }
}
