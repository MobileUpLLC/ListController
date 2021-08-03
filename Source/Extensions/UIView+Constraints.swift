//
//  UIView+Constraints.swift
//  ListController
//
//  Created by Pavel Petrovich on 06.04.2021.
//

import UIKit

// MARK: - UIView

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

// MARK: - LayoutInsets

struct LayoutInsets {

    // MARK: Public properties

    static var zero: LayoutInsets { self.init(top: 0, left: 0, bottom: 0, right: 0) }

    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?

    // MARK: Public methods

    static func insets(
        top: CGFloat? = 0,
        left: CGFloat? = 0,
        bottom: CGFloat? = 0,
        right: CGFloat? = 0
    ) -> LayoutInsets {
        return LayoutInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

// MARK: - UIView

extension UIView {

    // MARK: - Public methods

    func layoutSubview(
        _ view: UIView,
        with insets: LayoutInsets = .zero
    ) {
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        if let top = insets.top {
            view.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        }

        if let left = insets.left {
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left).isActive = true
        }

        if let bottom = insets.bottom {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottom).isActive = true
        }

        if let right = insets.right {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -right).isActive = true
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
