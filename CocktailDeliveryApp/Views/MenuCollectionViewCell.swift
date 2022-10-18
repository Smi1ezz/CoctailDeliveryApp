//
//  MenuCollectionViewCell.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    private var cocteilNameLabel: UILabel = {
        let cocteilNameLabel = UILabel()
        cocteilNameLabel.font = .boldSystemFont(ofSize: 17)
       return cocteilNameLabel
    }()

    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor.appColor(name: .appTextGray)

       return descriptionLabel
    }()

    private var photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
       return photoImage
    }()

    private var priceView: PriceUIView = {
        let priceView = PriceUIView()
        return priceView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(ofCoctail coctail: Drink, inCategory: String) {
        cocteilNameLabel.text = coctail.strDrink
        descriptionLabel.text = coctail.strCategory
        priceView.addPrice("354")
    }

    func setImage(_ image: UIImage?) {
        photoImage.image = image
        photoImage.backgroundColor = UIColor.appColor(name: .appCategHeaderSelectedBackgroundPink)
        photoImage.layer.cornerRadius = photoImage.frame.height/2
    }

    override func prepareForReuse() {
        photoImage.image = nil
    }

    private func setupSubviews() {
        [cocteilNameLabel, descriptionLabel, photoImage, priceView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        [cocteilNameLabel, descriptionLabel, photoImage, priceView].forEach({
            contentView.addSubview($0)
        })

        makeBottomLine()
        setupConstraints()
    }

    private func makeBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: contentView.frame.height - 1, width: contentView.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.appColor(name: .appSeporatorGray).cgColor
        contentView.layer.addSublayer(bottomLine)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImage.widthAnchor.constraint(equalToConstant: 132),
            photoImage.heightAnchor.constraint(equalToConstant: 132),

            cocteilNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            cocteilNameLabel.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 32),

            descriptionLabel.topAnchor.constraint(equalTo: cocteilNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 32),

            priceView.widthAnchor.constraint(equalToConstant: 87),
            priceView.heightAnchor.constraint(equalToConstant: 32),
            priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            priceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)

        ])
    }
}
