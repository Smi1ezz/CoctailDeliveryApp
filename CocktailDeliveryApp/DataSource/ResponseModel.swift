//
//  ResponseModel.swift
//  CocktailDeliveryApp
//
//  Created by admin on 13.10.2022.
//

import Foundation

// MARK: - CategoriesResponse
// www.thecocktaildb.com/api/json/v1/1/list.php?c=list

struct CategoriesResponse: Codable {
    let drinks: [Drink]?
}

// MARK: - CoctailsResponse
// www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail

struct CoctailsResponse: Codable {
    let drinks: [Drink]?
}

// MARK: - FullDetailsResponse
// www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11007

struct FullDetailsResponse: Codable {
    let drinks: [[String: String?]]?
}

// MARK: - Drink
struct Drink: Codable {
    var strCategory: String?

    let strDrink: String? // "155 Belmont"
    let strDrinkThumb: String? // "https:\/\/www.thecocktaildb.com\/images\/media\/drink\/yqvvqs1475667388.jpg"
    let idDrink: String? // "15346"

    mutating func setCategory(str: String) -> Drink {
        var cocWithCat = self
        cocWithCat.strCategory = str
        return cocWithCat
    }
}
