//
//  PokemonTeamGeneralService.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
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
