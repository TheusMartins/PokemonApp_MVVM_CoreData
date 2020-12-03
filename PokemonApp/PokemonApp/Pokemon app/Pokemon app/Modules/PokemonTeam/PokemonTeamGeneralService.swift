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
    //MARK: - Private properties
    private let coreDataManager: DBPokemonManager
    
    //MARK: - Initialization
    init(coreDataManager: DBPokemonManager = DBPokemonManager()) {
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Public methods
    func getAllPokemons() -> [DBPokemon] {
        return coreDataManager.getPokemons()
    }
}
