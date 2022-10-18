//
//  BarModel.swift
//  CocktailDeliveryApp
//
//  Created by admin on 14.10.2022.
//

import Foundation
import UIKit

protocol BarProtocol {
    func getCategories(complition: @escaping ([String]?) -> Void)
    func getCoctailsBy(category: String, complition: @escaping ([Drink]?) -> Void)
    func getImage(url: String?, complition: @escaping (UIImage?) -> Void)
}

class BarModel: BarProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getCategories(complition: @escaping ([String]?) -> Void) {
        networkManager.fetchData(endpoint: Endpoint.getCategories, modelType: CategoriesResponse.self) { result in
            switch result {
            case .success(let categories):
                guard let categories = categories as? CategoriesResponse else {
                    complition(nil)
                    return
                }

                guard let drinks = categories.drinks else {
                    complition(nil)
                    return
                }

                let categoriesArray = drinks.compactMap({$0.strCategory})

                complition(categoriesArray)
            case .failure(let error):
                print(error)
                complition(nil)
            }
        }
    }

    func getCoctailsBy(category: String, complition: @escaping ([Drink]?) -> Void) {

        networkManager.fetchData(endpoint: Endpoint.getCoctailsByCategory(category: category), modelType: CoctailsResponse.self) { result in
            switch result {
            case .success(let coctails):
                guard let coctails = coctails as? CoctailsResponse else {
                    complition(nil)
                    return
                }

                guard let drinks = coctails.drinks else {
                    complition(nil)
                    return
                }

                complition(drinks)

            case .failure(let error):
                print(error)
                complition(nil)
            }
        }
    }

    func getImage(url: String?, complition: @escaping (UIImage?) -> Void) {

        networkManager.fetchImage(fromURL: url) { result in
            switch result {
            case .success(let image):
                complition(image)

            case .failure(let error):
                print(error)
                complition(nil)
            }
        }
    }
}
