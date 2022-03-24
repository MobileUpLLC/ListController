//
//  UIView+Constraints.swift
//  ListController
//
//  Created by Pavel Petrovich on 06.04.2021.
//

import UIKit

extension UIView {

    func findConstraint(type: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraint = findConstraintInSuperview(type: type) {

            return constraint
        }

        return constraints.first(where: { $0.firstAttribute == type &&  $0.secondAttribute != type })
    }

    private func findConstraintInSuperview(type: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let superview = superview {

            for constraint in superview.constraints {

                let isFirstItemIsSelf = (constraint.firstItem as? UIView) == self
                let isSecondItemIsSelf = (constraint.secondItem as? UIView) == self
                let isConstraintAssociatedWithSelf = (isFirstItemIsSelf || isSecondItemIsSelf)

                if constraint.firstAttribute == type && isConstraintAssociatedWithSelf {

                    return constraint
                }
            }
        }

        return nil
    }
}

public struct LayoutInsets {
    
    static var zero: LayoutInsets { self.init(top: 0, left: 0, bottom: 0, right: 0) }

    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?
    
    static func insets(
        top: CGFloat? = 0,
        left: CGFloat? = 0,
        bottom: CGFloat? = 0,
        right: CGFloat? = 0
    ) -> LayoutInsets {
        return LayoutInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension UIView {
    
    func layoutSubview(
        _ view: UIView,
        with insets: LayoutInsets = .zero,
        safe: Bool = false
    ) {
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        if let top = insets.top {
            view.topAnchor.makeConstraint(equalTo: getTopAnchor(safe: safe), constant: top)
        }

        if let left = insets.left {
            view.leadingAnchor.makeConstraint(equalTo: getLeadingAnchor(safe: safe), constant: left)
        }

        if let bottom = insets.bottom {
            view.bottomAnchor.makeConstraint(equalTo: getBottomAnchor(safe: safe), constant: -bottom)
        }

        if let right = insets.right {
            view.trailingAnchor.makeConstraint(equalTo: getTrailingAnchor(safe: safe), constant: -right)
        }
    }

    func layoutSize(
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        translateAutoresizingMaskIntoConstraints: Bool = false
    ) {
        translatesAutoresizingMaskIntoConstraints = translateAutoresizingMaskIntoConstraints

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

extension UIView {
        
    func getTopAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        return safe ? safeAreaLayoutGuide.topAnchor : topAnchor
    }

    func getBottomAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        return safe ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
    }

    func getLeadingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
        return safe ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor
    }

    func getTrailingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
        return safe ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor
    }
}

extension NSLayoutAnchor {
        
    @objc func makeConstraint(equalTo anchor: NSLayoutAnchor, constant: CGFloat) {
        constraint(equalTo: anchor, constant: constant).isActive = true
    }
}
