//
//  CollectionController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

open class BaseCollectionViewController<SectionItem: Hashable, RowItem: Hashable>:
    BaseListViewController<SectionItem, RowItem> {
        
    open var collectionView: UICollectionView { fatalError("Collection view must be overriden") }
    
    lazy var dataSource = UICollectionViewDiffableDataSource<SectionItem, RowItem>(
        collectionView: collectionView,
        cellProvider: { [weak self] _, indexPath, item -> UICollectionViewCell? in
            return self?.dequeueReusableCell(for: item, at: indexPath)
        }
    )
    
    public var snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem> { dataSource.snapshot() }
        
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
