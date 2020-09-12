//
//  DownloadImageTargetType.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

enum DownloadImageTargetType {
    case getPokemonWithId(String)
    case getPokemonWithURL(URL)
}

extension DownloadImageTargetType: TargetType {
    var endpoint: String {
        switch self {
        case .getPokemonWithId(let pokemonId): return pokemonId
        case .getPokemonWithURL(_): return ""
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var baseURL: URL {
        switch self {
        case .getPokemonWithId(_): return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/")!
        case .getPokemonWithURL(let url): return url
        }
    }
}
