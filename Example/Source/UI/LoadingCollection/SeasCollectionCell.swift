//
//  SeasCollectionCell.swift
//  ListControllerExample
//
//  Created by vitalii on 09.08.2022.
//

import UIKit
import ListController

class SeasCollectionCell: UICollectionViewCell {
    
    var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeasCollectionCell: Configurable {
    
    func setup(with item: String) {
        label.text = item
        label.frame = contentView.frame
        
        backgroundColor = .random
    }
}

extension UIColor {
    
    static var random: UIColor {
        
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
