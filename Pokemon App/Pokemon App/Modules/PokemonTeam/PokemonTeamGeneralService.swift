//
//  PokemonTeamGeneralService.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

protocol PokemonTeamGeneralService {
    func getAllPokemons() -> [DBPokemon]
}

final class PokemonTeamGeneralServiceImpl: PokemonTeamGeneralService {
    
    let coreDataManager: DBPokemonManager
    
    init(coreDataManager: DBPokemonManager = DBPokemonManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func getAllPokemons() -> [DBPokemon] {
        return coreDataManager.getPokemons()
    }
}
