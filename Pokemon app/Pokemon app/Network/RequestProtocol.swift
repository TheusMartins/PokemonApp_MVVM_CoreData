//
//  RequestProtocol.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    associatedtype
    Target: TargetType
    func requestObject<Model: Codable>(model: Model.Type, _ target: Target, completionHandler: @escaping (Result<Model, Error>) -> Void)
    func requestData(target: Target, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class ProviderType<Target: TargetType> : RequestProtocol {
    //MARK: - Public methods
    func requestObject<Model>(model: Model.Type, _ target: Target, completionHandler: @escaping (Result<Model, Error>) -> Void) where Model : Codable {
        guard var url = URLComponents(string: "\(target.baseURL)\(target.endpoint)") else {
            completionHandler(.failure(NSError()))
            return
        }
        
        var components: [URLQueryItem] = []
        
        target.parameters?.forEach({ key, value in
            guard let stringValue = value as? Int else { return }
            components.append(URLQueryItem(name: key, value: "\(stringValue)"))
        })
        
        url.queryItems = components
        
        URLSession.shared.dataTask(with: url.url!) { data, resp, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError()))
                return
            }
            
            do {
                let modelList = try JSONDecoder().decode(Model.self , from: data)
                completionHandler(.success(modelList))
            } catch {
                completionHandler(.failure(NSError()))
            }
        }.resume()
    }
    
    func requestData(target: Target, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard var url = URLComponents(string: "\(target.baseURL)\(target.endpoint)") else {
            completionHandler(.failure(NSError()))
            return
        }
        
        var components: [URLQueryItem] = []
        
        target.parameters?.forEach({ key, value in
            guard let stringValue = value as? Int else { return }
            components.append(URLQueryItem(name: key, value: "\(stringValue)"))
        })
        
        url.queryItems = components
        
        URLSession.shared.dataTask(with: url.url!) { data, resp, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError()))
                return
            }
            
            completionHandler(.success(data))

        }.resume()
    }
}

