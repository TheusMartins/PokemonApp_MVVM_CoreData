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
    
    func removePokemonFromTeam(completion: @escaping(_ feedbackMessage: String) -> Void) {
        service.removeFromTeam(id: pokemon.id)
        completion("\(pokemon.name?.capitalized ?? "") has been removed from your team")
    }
}
