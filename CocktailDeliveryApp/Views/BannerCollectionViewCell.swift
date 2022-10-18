//
//  BannerCollectionViewCell.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    var photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.image = UIImage(named: "HardCodeBanner")
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 10
        photoImage.clipsToBounds = true
       return photoImage
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImage)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }

}
