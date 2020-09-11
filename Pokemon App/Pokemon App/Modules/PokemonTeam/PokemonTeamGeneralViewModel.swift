//
//  PokemonTeamGeneralViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonTeamGeneralViewModel {
    private let service: PokemonTeamGeneralService
    
    init(service: PokemonTeamGeneralService = PokemonTeamGeneralServiceImpl()) {
        self.service = service
    }
    
    func getAllLocalPokemons() -> [DBPokemon] {
        return service.getAllPokemons()
    }
}
