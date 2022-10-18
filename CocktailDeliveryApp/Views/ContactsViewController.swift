//
//  ContactsViewController.swift
//  CocktailDeliveryApp
//
//  Created by admin on 15.10.2022.
//

import UIKit

class ContactsViewController: UIViewController {
//    var collectionView: UICollectionView = {
//        let collectionViewLayout = UICollectionViewFlowLayout()
//        collectionViewLayout.scrollDirection = .horizontal
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collection.showsHorizontalScrollIndicator = false
//        return collection
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .brown
//        setupSubviews()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//    func generateCategoriesLayout() -> UICollectionViewLayout {
//        // 1
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .absolute(88),
//            heightDimension: .absolute(32)
//        )
//
//        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        // Отступы между items в каждой группе
//        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 24,
//            leading: 8,
//            bottom: 24,
//            trailing: 8
//        )
//
//        // 2
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(80)
//        )
//
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize,
//            subitem: fullPhotoItem,
//            count: 1
//        )
//
//        // 3
//        let section = NSCollectionLayoutSection(group: group)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//
//        return layout
//    }
//
//    private func setupSubviews() {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        //        collectionView.collectionViewLayout = generateCategoriesLayout()
//        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
//
//        view.addSubview(collectionView)
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }

}

// extension ContactsViewController: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
//            print("Wrong cell")
//            return UICollectionViewCell()
//        }
//        cell.backgroundColor = .red
//        return cell
//    }
//
// }
//
// extension ContactsViewController: UICollectionViewDelegate {
//
// }
