//
//  RequestProtocol.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    associatedtype
    Target: TargetType
    func requestObject<Model: Codable>(model: Model.Type, _ target: Target, completionHandler: @escaping (_ result: Model?, _ error: Error?) -> Void)
    func requestData(target: Target, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void)
}

class ProviderType<Target: TargetType> : RequestProtocol {
    func requestObject<Model>(model: Model.Type, _ target: Target, completionHandler: @escaping (Model?, Error?) -> Void) where Model : Codable {
        guard var url = URLComponents(string: "\(target.baseURL)\(target.endpoint)") else {
            completionHandler(nil, NSError())
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
                completionHandler(nil, error)
            }
            
            guard let data = data else {
                completionHandler(nil, NSError())
                return
            }
            
            do {
                let modelList = try JSONDecoder().decode(Model.self , from: data)
                completionHandler(modelList, nil)
            } catch {
                completionHandler(nil, NSError())
            }
        }.resume()
    }
    
    func requestData(target: Target, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard var url = URLComponents(string: "\(target.baseURL)\(target.endpoint)") else {
            completionHandler(nil, NSError())
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
                completionHandler(nil, error)
            }
            
            guard let data = data else {
                completionHandler(nil, NSError())
                return
            }
            
            completionHandler(data, nil)

        }.resume()
    }
}

