//
//  BaseListController.swift
//  ListController
//
//  Created by Nikolai Timonin on 27.04.2021.
//

import UIKit

// MARK: - BaseListViewController

open class BaseListViewController<SectionItem: Hashable, RowItem: Hashable>: UIViewController {

    // MARK: - Public properties
    
    open var defaultCellReuseIdentifier: String { "Cell" }
    open var defaultHeaderReuseIdentifier: String { "Header" }
    open var defaultFooterReuseIdentifier: String { "Footer" }
    
    // MARK: - Public methods

    /// Setup reusable view with item.
    /// - Parameters:
    ///   - view: View that adopts either Configurable of SenderConfigurable protocol.
    ///   - item: Item.
    open func setupConfigurableView(_ view: UIView, with item: Any) {
        if let view = view as? AnySenderConfigurable {
            view.anySetup(with: item, sender: self)
        } else if let view = view as? AnyConfigurable {
            view.anySetup(with: item)
        }
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open func cellReuseIdentifier(for rowItem: RowItem, at indexPath: IndexPath) -> String {
        return defaultCellReuseIdentifier
    }
}
