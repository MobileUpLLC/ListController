//
//  CollectionView.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import UIKit

class CollectionView: UICollectionView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
    }
    
    static func initiate() -> Self {
        return self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
}
