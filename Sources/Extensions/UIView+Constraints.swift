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

struct LayoutInsets {
    
    static var zero: LayoutInsets { self.init(top: .zero, left: .zero, bottom: .zero, right: .zero) }
    
    var top: CGFloat?
    var left: CGFloat?
    var bottom: CGFloat?
    var right: CGFloat?
    
    init(
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
    static func insets(
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
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
