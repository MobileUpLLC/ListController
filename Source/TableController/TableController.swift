//
//  TableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 06.04.2021.
//
// https://github.com/ra1028/DifferenceKit/blob/master/Examples/Example-iOS/Sources/Common/NibLoadable.swift UITableView.register(...)
// https://www.raywenderlich.com/10317653-calayer-tutorial-for-ios-getting-started CARepeaterLayer
// https://6ary.medium.com/combine-getting-started-guide-c5ac0febc04c Combine
// https://habr.com/ru/company/deliveryclub/blog/548792/ Compositonal Layout
// https://swiftsenpai.com/swift/section-snapshot-builder/ DSL

import UIKit

// MARK: - TableController

open class TableController<SectionItem: Hashable, RowItem: Hashable>: BaseTableController<SectionItem, RowItem>, UITableViewDelegate {
    
    // MARK: - Override methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    // MARK: - Public mehtods
    
    open func cellDidSelect(for item: RowItem, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open func dequeueReusableHeaderFooterView(with reuseIdentifier: String, for sectionItem: SectionItem) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else { return nil }
        setupConfigurableView(view, with: sectionItem)
        
        return view
    }
    
    open func headerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }
    
    open func footerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            assertionFailure("Don't find item of type: `\(RowItem.self)` for index path: \(indexPath)")
            return
        }
        
        cellDidSelect(for: item, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        guard let identifier = headerIdentifier(for: sectionItem, at: section) else { return nil }
        
        return dequeueReusableHeaderFooterView(with: identifier, for: sectionItem)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        guard let identifier = footerIdentifier(for: sectionItem, at: section) else { return nil }
        
        return dequeueReusableHeaderFooterView(with: identifier, for: sectionItem)
    }
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}
