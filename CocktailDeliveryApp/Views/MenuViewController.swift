//
//  MenuViewController.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import Foundation
import UIKit

protocol MenuViewDelegate: NSObjectProtocol {
    // сюда вписать все методы VC для передачи data из Presenter в View
    func setCategories(_ categories: [String])
    func addCoctailsToMenu(coctails: [Drink], fromCategory: String)
    func scrollTo(category: String)
}

class MenuViewController: UIViewController, MenuViewDelegate {
    // MARK: - я понимаю, что для следования принципу DI следует внедрять все зависимости извне, но для экономии времени на выполнение тестового задания, я выбрал верстку преимущественно через storyboard и поэтому пренебрегаю этим знанием. В реальном проекте я бы предложил отказаться от сториборд и внедрить роутер и\или координатор для инициализации viewController'ов и внедрения зависимостей.

    private var presenter: PresenterProtocol?
    private var categories = [String]()
    private var coctailsMenu = [String: [Drink]]()
    private var allCoctails = [Drink]()

    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.backgroundView = UIView()
        collection.backgroundView?.backgroundColor = UIColor.appColor(name: .appNaviBarBackground)
        return collection
    }()

    override func viewDidLoad() {
        view.backgroundColor = UIColor.appColor(name: .appNaviBarBackground)

        let networkManager = NetworkManager()
        let barModel = BarModel(networkManager: networkManager)
        presenter = Presenter(barModel: barModel)

        presenter?.setViewDelegate(self)
        presenter?.getCategories()

        setupCollection()

        setupSubviews()
        setupNavItem()
    }

    func setCategories(_ categories: [String]) {
        self.categories = categories
    }

    func addCoctailsToMenu(coctails: [Drink], fromCategory: String) {
        var coctWithCategs = [Drink]()
        for (index, coct) in coctails.enumerated() {
            var drink = coct
            coctWithCategs.insert(drink.setCategory(str: fromCategory), at: index)
        }
        coctailsMenu[fromCategory] = coctWithCategs

        if coctailsMenu.count == categories.count {
            fillMenu()
        }
    }

    func scrollTo(category: String) {
        let int = allCoctails.firstIndex(where: {$0.strCategory == category}) ?? 0

        collectionView.scrollToItem(at: IndexPath(item: int, section: 1),
                                    at: .top,
                                    animated: true)
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        collectionView.register(CategoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryCollectionReusableView")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")

        collectionView.collectionViewLayout = generateLayout()
    }

    private func fillMenu() {
        categories.forEach({allCoctails += coctailsMenu[$0] ?? []})
        collectionView.reloadSections([1])
    }

    private func setupNavItem() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = nil
        appearance.backgroundColor = UIColor.appColor(name: .appNaviBarBackground)

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .black

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Москва ⋁",
            style: .plain,
            target: self,
            action: #selector(selectCityAction))

    }

    @objc
    private func selectCityAction() {

    }

    private func setupSubviews() {
        self.view.addSubview(self.collectionView)

        self.collectionView.backgroundColor = UIColor.white

        setupConstraints()
    }

    func checkCategory(_ category: String) {

    }

    private func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    private func generateFirstSectionLayout() -> NSCollectionLayoutSection {
        let bannerView = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(300),
            heightDimension: .absolute(112))
        )

        bannerView.contentInsets = NSDirectionalEdgeInsets(
          top: 12,
          leading: 8,
          bottom: 12,
          trailing: 8)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .absolute(112+12+12)),

            subitem: bannerView,
            count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    private func generateSecondSectionLayout() -> NSCollectionLayoutSection {
        let menuElement = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(180))
        )

        menuElement.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 0,
          bottom: 0,
          trailing: 0)

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(180)),
            subitem: menuElement,
            count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))

        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        headerElement.pinToVisibleBounds = true

        section.boundarySupplementaryItems = [headerElement]

        return section
    }

    private func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

        switch sectionIndex {
        case 0: return self.generateFirstSectionLayout()
        case 1: return self.generateSecondSectionLayout()
        default: return self.generateFirstSectionLayout()
        }
      }
      return layout
    }

}

extension MenuViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return allCoctails.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:

            switch indexPath.section {
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryCollectionReusableView", for: indexPath) as! CategoryCollectionReusableView

                header.setupCollectionView(categories: categories)
                header.setDelegate(self)

                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath)

                return header
            }

        case UICollectionView.elementKindSectionFooter:

            return UICollectionReusableView()

        default:

            assert(false, "Unexpected element kind")
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
                print("Wrong cell")
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else {
                print("Wrong cell")
                return UICollectionViewCell()
            }
            cell.setupCell(ofCoctail: allCoctails[indexPath.item],
                           inCategory: allCoctails[indexPath.item].strCategory ?? "")
            presenter?.getImage(fromUrl: allCoctails[indexPath.item].strDrinkThumb,
                                complition: { image in
                DispatchQueue.main.async {
                    cell.setImage(image)
                }
            })

            return cell
        default:
            return UICollectionViewCell()
        }

    }

}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let array = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)

        guard !array.isEmpty, !allCoctails.isEmpty, let header = array.first as? CategoryCollectionReusableView else {
            return
        }

        header.checkCategory(allCoctails[indexPath.item].strCategory ?? "")

    }
}
