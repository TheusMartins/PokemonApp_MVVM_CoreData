//
//  PokemonDetailsModel.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation

struct PokemonDetailsModel: Codable {
    let id: Int32
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
}

struct PokemonSprites: Codable {
    let front: URL
    let back: URL
    
    enum CodingKeys: String, CodingKey {
        case front = "front_default"
        case back = "back_default"
    }
}

struct PokemonType: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
