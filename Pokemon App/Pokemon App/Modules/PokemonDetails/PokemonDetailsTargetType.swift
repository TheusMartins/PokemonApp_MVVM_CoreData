//
//  PokemonDetailsTargetType.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

enum PokemonDetailsTargetType {
    case getPokemonDetails(String)
}

extension PokemonDetailsTargetType: TargetType {
    var endpoint: String {
        switch self {
        case .getPokemonDetails(let pokemonName): return pokemonName
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
}
