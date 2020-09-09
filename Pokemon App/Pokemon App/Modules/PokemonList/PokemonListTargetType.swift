//
//  PokemonListTargetType.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

enum PokemonListTargetType {
    case getContacts
}

extension PokemonListTargetType: TargetType {
    var endpoint: String {
        return "pokemon?limit=1050&offset=0"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
