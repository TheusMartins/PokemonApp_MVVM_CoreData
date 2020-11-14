//
//  PokemonDetailsModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

struct PokemonDetailsModel: Codable {
    let id: Int32
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
}

struct PokemonSprites: Codable {
    let front: URL?
    
    enum CodingKeys: String, CodingKey {
        case front = "front_default"
    }
}

struct PokemonType: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
