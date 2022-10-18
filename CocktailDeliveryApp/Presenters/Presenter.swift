//
//  Presenter.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import Foundation
import UIKit

protocol PresenterProtocol {
    func setViewDelegate(_ delegate: MenuViewDelegate)
    func getCategories()
    func getImage(fromUrl url: String?, complition: @escaping (UIImage?) -> Void)
}

class Presenter: PresenterProtocol {
    private let barModel: BarProtocol
    weak private var presentedViewDelegate: MenuViewDelegate?

    init(barModel: BarProtocol) {
        self.barModel = barModel
    }

    func setViewDelegate(_ delegate: MenuViewDelegate) {
        self.presentedViewDelegate = delegate
    }

    func getCategories() {
        barModel.getCategories { [weak self] categoriesArray in
            guard let categoriesArray = categoriesArray else {
                print("Presenter let categoriesArray = categoriesArray nil")
                return
            }
            DispatchQueue.main.async {
                self?.presentedViewDelegate?.setCategories(categoriesArray)
                self?.getCoctails(ofCategories: categoriesArray)
            }
        }
    }

    func getImage(fromUrl url: String?, complition: @escaping (UIImage?) -> Void) {
        barModel.getImage(url: url) { image in
            guard let image = image else {
                print("no UIImage in call")
                complition(nil)
                return
            }
            complition(image)
        }
    }

    private func getCoctails(ofCategories categories: [String]) {
        categories.forEach { category in
            barModel.getCoctailsBy(category: category) { [weak self] coctails in
                guard let coctails = coctails else {
                    print("Presenter let coctail = coctail nil")
                    return
                }
                DispatchQueue.main.async {
                    self?.presentedViewDelegate?.addCoctailsToMenu(coctails: coctails, fromCategory: category)
                }
            }
        }
    }

}
