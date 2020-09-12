//
//  PokemonListModel.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation

struct PokemonListModel: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: URL
}
