//
//  CollectionController.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

// MARK: - CollectionController

class CollectionController<SectionItem: Hashable, RowItem: Hashable>: BaseCollectionController<SectionItem, RowItem>, UICollectionViewDelegate {
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
    }
    
    // MARK: - Public methods
    
    open func cellDidSelect(for item: RowItem, at indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            assertionFailure("Don't find item of type: `\(RowItem.self)` for index path: \(indexPath)")
            return
        }
        
        cellDidSelect(for: item, at: indexPath)
    }
}

