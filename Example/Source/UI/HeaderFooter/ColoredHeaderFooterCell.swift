//
//  ColoredHeaderCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import UIKit
import ListController

// MARK: - ColoredHeaderCell

class ColoredHeaderFooterCell: UITableViewCell {

    // MARK: - Public properties

    static let reuseId = "ColoredHeaderFooterCell"

    // MARK: - Public methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(named: "lightBlue")
    }
}

// MARK: - Configurable

extension ColoredHeaderFooterCell: Configurable {

    // MARK: - Public methods

    func setup(with item: HeaderFooterItem) {
        switch item {
        case .header(let title), .footer(let title):
            textLabel?.text = title
        default:
            break
        }
    }
}
