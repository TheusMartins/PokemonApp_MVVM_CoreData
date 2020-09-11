//
//  PokemonService.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

protocol PokemonService {
    func removeFromTeam(id: Int32)
}

final class PokemonServiceImpl: PokemonService {
    let coreDataManager: DBPokemonManager
    
    init(coreDataManager: DBPokemonManager = DBPokemonManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func removeFromTeam(id: Int32) {
        coreDataManager.deletePokemon(pokemonId: id)
    }
}
