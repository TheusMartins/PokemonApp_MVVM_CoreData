//
//  PokemonListTargetType.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

enum PokemonListTargetType {
    case getContacts(Int, Int)
}

//MARK: - TargetType
extension PokemonListTargetType: TargetType {
    var endpoint: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getContacts(let limit, let offset): return [
            "limit" : limit,
            "offset" : offset
        ]
        }
    }
}
