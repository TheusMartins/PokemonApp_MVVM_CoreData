//
//  PokemonViewModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

final class PokemonViewModel {
    private let service: PokemonService
    private let pokemon: PokemonModel
    
    init(
        service: PokemonService = PokemonServiceImpl(),
        pokemon: PokemonModel
    ) {
        self.service = service
        self.pokemon = pokemon
    }
    
    func removePokemonFromTeam(completion: @escaping(_ feedbackMessage: String) -> Void) {
        service.removeFromTeam(id: pokemon.id)
        completion("\(pokemon.name?.capitalized ?? "") has been removed from your team")
    }
    
    func getPokemonName() -> String {
        return pokemon.name ?? ""
    }
    
    func getPokemonInfos() -> PokemonModel {
        return pokemon
    }
}
