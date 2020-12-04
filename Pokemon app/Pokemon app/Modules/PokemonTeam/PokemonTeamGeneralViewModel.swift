//
//  PokemonTeamGeneralViewModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

final class PokemonTeamGeneralViewModel {
    //MARK: - Private properties
    private let service: PokemonTeamGeneralService
    
    //MARK: - Initialization
    init(service: PokemonTeamGeneralService = PokemonTeamGeneralServiceImpl()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func getAllLocalPokemons() -> [DBPokemon] {
        return service.getAllPokemons()
    }
}
