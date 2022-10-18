//
//  PriceUIView.swift
//  CocktailDeliveryApp
//
//  Created by admin on 18.10.2022.
//

import UIKit

class PriceUIView: UIView {
    private var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.textColor = UIColor.appColor(name: .appCategHeaderSelectedTextPink)
       return priceLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appColor(name: .appCategHeaderSelectedTextPink).cgColor
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addPrice(_ price: String?) {
        guard let price = price else {
            return
        }
        priceLabel.text = "от " + price + " р"
    }

    private func setupSubviews() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
