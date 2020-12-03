//
//  RequestInfos.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol TargetType {
    
    var baseURL: URL { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }

}

public extension TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    }
}
