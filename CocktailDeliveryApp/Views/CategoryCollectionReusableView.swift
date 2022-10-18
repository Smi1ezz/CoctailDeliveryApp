//
//  CategoryCollectionReusableView.swift
//  CocktailDeliveryApp
//
//  Created by admin on 15.10.2022.
//

import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {

    private var categories: [String]?
    private var delegate: MenuViewDelegate?
    private var categoryToCheck: String?

    var collectionView: UICollectionViewWithComletion = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collection = UICollectionViewWithComletion(frame: .zero, collectionViewLayout: collectionViewLayout)

        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.appColor(name: .appNaviBarBackground)
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = UIColor.appColor(name: .appShadowGray).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5.0
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                          y: bounds.maxY - layer.shadowRadius * 2,
                                                          width: bounds.width,
                                                          height: layer.shadowRadius)).cgPath
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView(categories: [String]) {
        self.categories = categories
        collectionView.reloadDataWith { [weak self] in
            guard self?.collectionView.numberOfSections != 0 else {
                return
            }
            self?.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }

    }

    func setDelegate(_ delegate: MenuViewDelegate) {
        self.delegate = delegate
    }

    func checkCategory(_ checkedCategory: String) {
        guard categoryToCheck != nil else {
            categoryToCheck = checkedCategory
            return
        }
        guard let categories = categories, checkedCategory != categoryToCheck else {
            return
        }
        print("checkCategory," + checkedCategory)

        categoryToCheck = checkedCategory
        for (index, category) in categories.enumerated() where category == checkedCategory {
            collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }

    private func setupSubviews() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        self.addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 68),

            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

extension CategoryCollectionReusableView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return categories?.isEmpty ?? true ? 0 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            print("Wrong cell")
            return UICollectionViewCell()
        }
        cell.setLabel(categories?[indexPath.item] ?? "wrong")
        cell.changeIndexTo(index: indexPath.item)

        return cell
    }

}

extension CategoryCollectionReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("collection cell tapped")
        delegate?.scrollTo(category: categories?[indexPath.item] ?? "")

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 8, bottom: 24, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }

}

extension CategoryCollectionReusableView: UICollectionViewDelegate {

}
