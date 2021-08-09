//
//  HeaderFooterViewController.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import UIKit
import ListController

// MARK: - HeaderFooterItem

enum HeaderFooterItem: Hashable {
    case header(_ title: String)
    case footer(_ title: String)
    case item(_ item: PrimitiveItem)
}

// MARK: - HeaderFooterViewController

class HeaderFooterViewController: TableController<Int, HeaderFooterItem> {

    // MARK: - Override properties

    override var tableView: UITableView { headerFooterTableView }

    // MARK: - Private properties

    private let headerFooterTableView = UITableView(frame: .zero, style: .grouped)

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "HeaderFooter"

        setupTable()

        tableView.register(ColoredHeaderFooterCell.self, forCellReuseIdentifier: ColoredHeaderFooterCell.reuseId)
        tableView.register(PrimitiveItemCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)

        apply(items: makeItems())
    }

    override func cellReuseIdentifier(for rowItem: HeaderFooterItem, at indexPath: IndexPath) -> String {
        switch rowItem {
        case .header, .footer:
            return ColoredHeaderFooterCell.reuseId
        case .item:
            return defaultCellReuseIdentifier
        }
    }

    // MARK: - Private methods

    private func makeItems() -> [HeaderFooterItem] {
        var items = [HeaderFooterItem]()

        items.append(.header("Header | String"))
        items.append(contentsOf: ["Value 1", "Value 2", "Value 3"].map {
            HeaderFooterItem.item(PrimitiveItem(value: $0))
        })
        items.append(.footer("Footer | String"))

        items.append(.header("Header | Int"))
        items.append(contentsOf: [3, 4, 5].map {
            HeaderFooterItem.item(PrimitiveItem(value: $0))
        })
        items.append(.footer("Footer | Int"))

        return items
    }
}
