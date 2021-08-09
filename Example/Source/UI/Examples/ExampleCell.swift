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

        let markImage = UIImage(systemName: "chevron.right")
        let mark = UIImageView(image: markImage)
        mark.tintColor = .darkGray

        let stackView = UIStackView(arrangedSubviews: [nameLabel, mark])
        stackView.axis = .horizontal

        contentView.addSubview(view)
        view.addSubview(stackView)

        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        mark.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mark.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
}

// MARK: - Configurable

extension ExampleCell: Configurable {

    // MARK: - Public methods

    func setup(with item: Example) {
        nameLabel.text = item.name
    }
}
