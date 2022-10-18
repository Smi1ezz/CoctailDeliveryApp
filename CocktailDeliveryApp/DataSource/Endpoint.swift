//
//  Endpoint.swift
//  CocktailDeliveryApp
//
//  Created by admin on 13.10.2022.
//
// www.thecocktaildb.com/api/json/v1/1/list.php?c=list
// www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail

import Foundation
import Alamofire

enum HTTPMethods: String {
    case GET, SET, POST, DELETE
}

protocol EndpointProtocol {
    var httpMethod: HTTPMethods {get}
    var headers: [String: String] {get}
    var scheme: String {get}
    var host: String {get}
    var path: String {get}
    var parameters: [URLQueryItem] {get}
    var strURL: String? {get}

}

enum Endpoint: EndpointProtocol {
    case getCategories, getCoctailsByCategory(category: String)

    var httpMethod: HTTPMethods {
        switch self {
        case .getCategories:
            return .GET
        case .getCoctailsByCategory:
            return .GET
        }
    }

    var headers: [String: String] {
        switch self {
        case .getCategories:
            return ["API key": "1"]
        case .getCoctailsByCategory:
            return ["API key": "1"]
        }
    }

    var scheme: String {
        return "https"
    }

    var host: String {
        return "www.thecocktaildb.com"
    }

    var path: String {
        switch self {
        case .getCategories:
            return "/api/json/v1/1/list.php"
        case .getCoctailsByCategory:
            return "/api/json/v1/1/filter.php"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getCategories:
            return [URLQueryItem(name: "c", value: "list")]
        case .getCoctailsByCategory(let category):
            return [URLQueryItem(name: "c", value: "\(category)")]
        }
    }

    var strURL: String? {
        return makeStringURL()
    }

    private func makeStringURL() -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters

        return urlComponents.string
    }

//    func singlePhotoEndpoint(id: String) -> [URLQueryItem] {
//        return [URLQueryItem(name: "client_id", value: "WKyQ7vpmCzL06dijhELIkIYRYZDzz1GisBLIA3lxKek"),
//                URLQueryItem(name: "id", value: id)
//        ]
//
//    }

}
