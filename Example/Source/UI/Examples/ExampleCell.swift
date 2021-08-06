//
//  ExampleCell.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit
import ListController

// MARK: - ExampleCell

class ExampleCell: UITableViewCell {

    // MARK: - Private properties

    private let nameLabel = UILabel()

    // MARK: - Public methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        makeContentView()
    }

    // MARK: - Private methods

    private func makeContentView() {
        let view = UIView()

        contentView.addSubview(view)

        view.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
        }

        let markImage = UIImage(systemName: "chevron.right")

        let mark = UIImageView(image: markImage)
        mark.tintColor = .darkGray

        let stackView = UIStackView(arrangedSubviews: [nameLabel, mark])
        stackView.axis = .horizontal

        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }

        mark.snp.makeConstraints { make in
            make.trailing.equalTo(stackView.snp.trailing)
        }
    }
}

// MARK: - Configurable

extension ExampleCell: Configurable {

    // MARK: - Public methods

    func setup(with item: Example) {
        nameLabel.text = item.name
    }
}
