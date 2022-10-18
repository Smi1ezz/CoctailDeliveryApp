//
//  CategoryCollectionViewCell.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    private var index: Int?

    private var categLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.appColor(name: .appCategHeaderDeselectedPink)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.appColor(name: .appCategHeaderDeselectedPink).cgColor
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor.appColor(name: .appCategHeaderSelectedBackgroundPink) : UIColor.appColor(name: .appNaviBarBackground)
            self.contentView.layer.borderWidth = isSelected ? 0 : 1
            categLabel.textColor = isSelected ? UIColor.appColor(name: .appCategHeaderSelectedTextPink) : UIColor.appColor(name: .appCategHeaderDeselectedPink)
            categLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 13) : UIFont.systemFont(ofSize: 13)
        }
    }

    func changeIndexTo(index: Int) {
        self.index = index
    }

    func setLabel(_ text: String) {
        categLabel.text = text
    }

    private func setupSubviews() {
        categLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
}
