//
//  ColoredHeaderCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 09.08.2021.
//

import UIKit
import ListController

class ColoredHeaderFooterCell: UITableViewCell {
    
    static let reuseId = "ColoredHeaderFooterCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(named: "lightBlue")
    }
}

extension ColoredHeaderFooterCell: Configurable {
    
    func setup(with item: HeaderFooterItem) {
        switch item {
        case .header(let title), .footer(let title):
            textLabel?.text = title
        default:
            break
        }
    }
}
