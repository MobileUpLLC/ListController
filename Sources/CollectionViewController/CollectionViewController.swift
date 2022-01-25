//
//  CollectionController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

open class CollectionViewController<SectionItem: Hashable, RowItem: Hashable>:
    BaseCollectionViewController<SectionItem, RowItem>, UICollectionViewDelegate {
        
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
    }
        
    open func cellDidSelect(for item: RowItem, at indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
        
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            assertionFailure("Don't find item of type: `\(RowItem.self)` for index path: \(indexPath)")
            return
        }
        
        cellDidSelect(for: item, at: indexPath)
    }
}
