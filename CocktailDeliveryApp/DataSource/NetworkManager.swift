//
//  NetworkManager.swift
//  CocktailDeliveryApp
//
//  Created by admin on 13.10.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<Codable, Error>) -> Void)
    func fetchImage(fromURL: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func fetchData<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<Codable, Error>) -> Void) {

        guard let urlString = endpoint.strURL else {
            print("urlString = endpoint.strURL nil")

            return
        }

        AF.request(urlString).validate().responseDecodable(of: modelType.self) { result in
            switch result.result {
            case .success(let data):
                complition(.success(data))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }

    func fetchImage(fromURL: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> Void) {

        guard let urlString = fromURL else {
            return
        }

        AF.request(urlString).validate().responseData { data in
            switch data.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                complition(.success(image))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}
