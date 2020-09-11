//
//  PokemonDetailsViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonDetailsViewModel {
    private let service: PokemonDetailsService & PokemonDetailsCoreDataOperations
    private let pokemonName: String
    private var pokemonModel: PokemonDetailsModel?
    
    init(
        service: PokemonDetailsService & PokemonDetailsCoreDataOperations = PokemonDetailsServiceImpl(),
        pokemonName: String
    ) {
        self.service = service
        self.pokemonName = pokemonName
    }
    
    func getPokemon(completion: @escaping(_ model: PokemonDetailsModel) -> Void) {
        service.getPokemon(pokemonName: pokemonName) { [weak self] model, error in
            guard let model = model else { return }
            self?.pokemonModel = model
            completion(model)
        }
    }
    
    func addPokemon(completion: @escaping(_ feedbackMessage: String) -> Void) {
        guard let pokemon = pokemonModel else { return }
        if service.canAddPokemon() {
            service.addPokemon(model: pokemon)
            completion("Pokemon successfully added")
        } else {
            completion("Pokemon not added, your team is complete or you already have this pokemon in your team")
        }
    }
}
