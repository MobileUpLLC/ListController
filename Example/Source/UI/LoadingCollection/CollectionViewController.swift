//
//  CollectionViewController.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import UIKit

enum CollectionSection: Hashable, CaseIterable {
    
    case oneItemInRow
    case twoItemsInRow
}

enum CollectionItem: Hashable {
    
    case sea(String)
}

class CollectionViewController: BaseLoadingCollectionViewController<CollectionSection, CollectionItem> {
    
    override var collectionView: UICollectionView { collectioinView }
    override var hasRefresh: Bool { true }
    
    private var collectioinView = CollectionView.initiate()
    private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, CollectionItem>!
    private var interactor = CollectionInteractor()
    private var seas: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
        getSeas()
    }
    
    override func refreshDidStartLoading(_ refreshControl: UIRefreshControl) {
        super.refreshDidStartLoading(refreshControl)
        
        getSeas()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .sea(let seaName):
            print(seaName)
        }
    }
    
    private func setupCollectionView() {
        view.layoutSubview(collectionView, with: .insets(top: nil, left: 0, bottom: 0, right: 0), safe: true)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.backgroundColor = .clear
        
        view.sendSubviewToBack(collectionView)
        
        collectionView.collectionViewLayout = generateLayout()
        
        collectionView.register(SeasCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func getSeas() {
        refreshControl.beginRefreshing()
        interactor.getSeas { [weak self] seas in
            self?.seas = seas
            self?.configureDataSource()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = CollectionSection.allCases[sectionIndex]
            
            return self?.setupLayoutForSection(sectionLayoutKind)
        }
        
        return layout
    }
    
    private func setupLayoutForSection(_ section: CollectionSection) -> NSCollectionLayoutSection? {
        switch section {
        case .oneItemInRow:
            return generateOneItemInRowLayout()
        case .twoItemsInRow:
            return generateTwoItemsInRowLayout()
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <CollectionSection, CollectionItem>(collectionView: collectionView) { [weak self] (
            collectionView: UICollectionView, indexPath: IndexPath, dataItem: CollectionItem
        ) -> UICollectionViewCell? in
            self?.getCellForItem(dataItem, collectionView: collectionView, indexPath: indexPath)
        }
        applySnapshotForCurrentState()
    }
    
    private func getCellForItem(
        _ item: CollectionItem,
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        ) as? SeasCollectionCell
        
        guard let cell = cell else {
            return UICollectionViewCell()
        }
        switch item {
        case .sea(let name):
            cell.setup(with: name)
        }
        return cell
    }
    
    private func applySnapshotForCurrentState() {
    
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, CollectionItem>()
        snapshot.appendSections(CollectionSection.allCases)
        let quarterOfSeas = seas[0 ..< seas.count / 4]
        let leftSplit = quarterOfSeas[0 ..< quarterOfSeas.count / 2].map { CollectionItem.sea($0) }
        let rightSplit = quarterOfSeas[quarterOfSeas.count / 2 ..< quarterOfSeas.count].map { CollectionItem.sea($0) }
        
        snapshot.appendItems(leftSplit, toSection: .oneItemInRow)
        snapshot.appendItems(rightSplit, toSection: .twoItemsInRow)
        dataSource.apply(snapshot)
    }
    
    private func generateOneItemInRowLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        return layoutSection
    }
    
    private func generateTwoItemsInRowLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        return layoutSection
    }
}
