//
//  CollectionController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

// MARK: - BaseCollectionController

open class BaseCollectionController<SectionItem: Hashable, RowItem: Hashable>: BaseListController<SectionItem, RowItem> {
    
    // MARK: - Public properties
    
    open var collectionView: UICollectionView { fatalError() }
    
    lazy var dataSource = UICollectionViewDiffableDataSource<SectionItem, RowItem>(
        collectionView: collectionView,
        cellProvider: { [weak self] (collection, indexPath, item) -> UICollectionViewCell? in
            return self?.dequeueReusableCell(for: item, at: indexPath)
        }
    )
    
    public var snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem> { dataSource.snapshot() }
    
    // MARK: - Public methods
    
    /// Важно: в снепшот сначала нужно добавить секции, а потом айтемы. Иначе креш
    open func apply(
        _ snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem>,
        animating: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        dataSource.apply(snapshot, animatingDifferences: animating, completion: completion)
    }
    
    open func dequeueReusableCell(for item: RowItem, at indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = cellReuseIdentifier(for: item, at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        setupConfigurableView(cell, with: item)
        
        return cell
    }
}
