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

## Requirements

- Swift 5.1+
- iOS 13.0+
