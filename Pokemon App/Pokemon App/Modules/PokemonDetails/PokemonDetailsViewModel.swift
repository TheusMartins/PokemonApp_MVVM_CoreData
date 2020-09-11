//
//  PokemonDetailsViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonDetailsViewModel {
    private let service: PokemonDetailsService
    private let pokemonName: String
    private var pokemonModel: PokemonDetailsModel?
    
    init(
        service: PokemonDetailsService = PokemonDetailsServiceImpl(),
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
    
    func addPokemon() {
        
    }
}
