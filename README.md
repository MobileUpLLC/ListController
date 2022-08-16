# ListController

<div align="center">

[![Platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)](https://www.apple.com/ios) [![Language: Swift 5](https://img.shields.io/badge/swift-5.1-orange)](https://swift.org) [![CocoaPods compatible](https://img.shields.io/badge/pod-1.1.0-blue.svg)](https://github.com/MobileUpLLC/ListController) [![SwiftPM compatible](https://img.shields.io/badge/swift_package-1.1.0-blue.svg)](https://swift.org/package-manager/) [![License: MIT](https://img.shields.io/badge/license-MIT-green)](https://github.com/MobileUpLLC/ListController/blob/main/LICENSE)

</div>


Provides an abstraction layer to deal with listable data. It's a simpler and faster way to build table views on top of this than from scratch.

## Usage

### 1. Setup models and reusable views

#### 1.1 Model setup

Item for cells must adopt `Hashable` protocol.

#### 1.2 Cells setup

Table view cell should conform to `Configurable` protocol in order to receive cell item for setup.

```swift
extension Cell: Configurable {

    public func setup(with item: User) {

        textLabel?.text = item.name
    }
}
```

Sometimes you need to set delegate for cell, header or footer. For that purpose table adapter has `sender` property, which will be passed to configurable view, that adopts `SenderConfigurable` protocol.

```swift
extension Cell: SenderConfigurable {

    func setup(with item: Item, sender: ViewController) {

        textLabel?.text = object.name
        delegate = sender
    }
}
```

### 2. Use TableController as parent class

You must provide `tableView` property. 

```swift
class ExamplesViewController: TableController<Int, Example> {

    override var tableView: UITableView { examplesTableView }
    
    private let examplesTableView = UITableView(frame: .zero, style: .grouped)
    private let items: [Example] = [ ... ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup table
        view.addSubview(tableView)
        tableView.register(ExampleCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)

        apply(items: items)
    }
    
    func apply(items: [RowItem], animated: Bool = false) {
        var snapshot = snapshot

        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        apply(snapshot, animating: animated)
    }
}
```

### 3. Use PagingTableViewController as parent class
PageProvider - performs work with pages. You need to implement a class inherited from the PageProvider class.
```swift
    override var pageProvider: ExampleInteractor { interactor }
    private let interactor = ExampleInteractor()
```
```swift
   import ListController

    class ExampleInteractor: LimitOffsetPageProvider {    
        
        typealias T = String
        
        var allItems: [String] = []
        var loadedPagesCount: Int = 0
        var isDataEmpty: Bool { allItems.isEmpty }
        
        private let gateway = ExampleGateway()
            
        func getItems(limit: Int, offset: Int, completion: @escaping (Result<Page<String>, Error>) -> Void) {
            gateway.getExamples(limit: limit, offset: offset) { result in
                let page = result
                    .map { Page(items: $0, hasMore: $0.count == limit) }
                    .mapError { $0 as Error }
                completion(page)
            }
        }
    }
```
Variables that allow you to customize your workflow 
```swift
    override var tableView: UITableView { paginationTableView }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override var rowAnimation: UITableView.RowAnimation { .fade }
    override var hasRefresh: Bool { true }
    override var hasPagination: Bool { true }
```
You can control the work with the network using the methods below
```swift
    override func requestInitialItems() {
        super.requestInitialItems()
        // Do some on requestInitialItems
        // for example: Start animating activity indicator
    }
```
```swift
     override func handleInitialItems(_ pageResult: PageResult<Provider.T>) {
        super.handleInitialItems(pageResult)
        // Do some on requestInitialItems
        // for example: Stop animating activity indicator
    }
```
```swift
    override func handleInitialError(_ error: Error) {
        super.handleInitialError(error)
    }
```
The map method is needed to create a NSDiffableDataSourceSnapshot from new and all values
```swift
    open func map(
        newItems: [Provider.T],
        allItems: [Provider.T]
    ) -> NSDiffableDataSourceSnapshot<SectionItem, RowItem> {
        fatalError("Map should be overriden")
    }
```
Override these method if you want to customize the work with requests for first pages
```swift
    open func requestRefreshItems() {
        pageProvider.getFirstPage { [weak self] result in
            switch result {
            case .success(let pageResult):
                self?.handleRefreshItems(pageResult)
            case .failure(let error):
                self?.handleRefreshError(error)
            }
        }
    }
```
Override these method if you want to customize the work with requests for next pages
```swift
    open func requestNextPageItems() {
        pageProvider.getNextPage { [weak self] result in
            switch result {
            case .success(let pageResult):
                self?.handlePagingItems(pageResult)
            case .failure(let error):
                self?.handlePagingError(error)
            }
        }
    }
```
### 4. Use CollectionViewController as parent class
You need to override collectionView by setting your own collectionView
```swift
    override var collectionView: UICollectionView { exampleView }
```
Use these methods to handle cell selection
```swift
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
```
This method allows you to recreate the table with the changed values
```swift
    /// Important: in the snapshot, you first need to add sections, and then items. Otherwise crash
    open func apply(
        _ snapshot: NSDiffableDataSourceSnapshot<SectionItem, RowItem>,
        animating: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        dataSource.apply(snapshot, animatingDifferences: animating, completion: completion)
    }
```
Use this method to handle refresh loading
```swift
    override func refreshDidStartLoading(_ refreshControl: UIRefreshControl) {
        super.refreshDidStartLoading(refreshControl)
        // Do some on refreshing
    }
```

## Requirements

- Swift 5.1+
- iOS 13.0+
