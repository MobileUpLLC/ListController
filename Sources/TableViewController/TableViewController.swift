//
//  TableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 06.04.2021.
//
// UITableView.register(...)
// https://github.com/ra1028/DifferenceKit/blob/master/Examples/Example-iOS/Sources/Common/NibLoadable.swift
// https://www.raywenderlich.com/10317653-calayer-tutorial-for-ios-getting-started CARepeaterLayer
// https://6ary.medium.com/combine-getting-started-guide-c5ac0febc04c Combine
// https://habr.com/ru/company/deliveryclub/blog/548792/ Compositonal Layout
// https://swiftsenpai.com/swift/section-snapshot-builder/ DSL

import UIKit

open class TableViewController<SectionItem: Hashable, RowItem: Hashable>:
    BaseTableViewController<SectionItem, RowItem>, UITableViewDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
    }
    
    open func cellDidSelect(for item: RowItem, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open func dequeueReusableHeaderView(
        with reuseIdentifier: String,
        for sectionItem: SectionItem,
        at sectionIndex: Int
    ) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else {
            return nil
        }
        
        let configurableItem = prepareSectionHeaderItem(sectionItem, at: sectionIndex)
        setupConfigurableView(view, with: configurableItem)
        
        return view
    }
    
    open func dequeueReusableFooterView(
        with reuseIdentifier: String,
        for sectionItem: SectionItem,
        at sectionIndex: Int
    ) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else {
            return nil
        }
        
        let configurableItem = prepareSectionFooterItem(sectionItem, at: sectionIndex)
        setupConfigurableView(view, with: configurableItem)
        
        return view
    }

    open func headerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }

    open func footerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }
    
    open func prepareSectionHeaderItem(_ item: SectionItem, at sectionIndex: Int) -> Any {
        return item
    }
    
    open func prepareSectionFooterItem(_ item: SectionItem, at sectionIndex: Int) -> Any {
        return item
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            assertionFailure("Don't find item of type: `\(RowItem.self)` for index path: \(indexPath)")
            return
        }

        cellDidSelect(for: item, at: indexPath)
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        
        guard let identifier = headerIdentifier(for: sectionItem, at: section) else {
            return nil
        }
        
        return dequeueReusableHeaderView(with: identifier, for: sectionItem, at: section)
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        
        guard let identifier = footerIdentifier(for: sectionItem, at: section) else {
            return nil
        }
        
        return dequeueReusableFooterView(with: identifier, for: sectionItem, at: section)
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    open func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}
