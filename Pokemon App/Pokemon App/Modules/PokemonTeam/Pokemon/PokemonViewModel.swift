//
//  PokemonViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonViewModel {
    private let service: PokemonService
    private let pokemon: DBPokemon
    
    init(
        service: PokemonService = PokemonServiceImpl(),
        pokemon: DBPokemon
    ) {
        self.service = service
        self.pokemon = pokemon
    }
    
    func removePokemonFromTeam() {
        service.removeFromTeam(id: pokemon.id)
    }
}
