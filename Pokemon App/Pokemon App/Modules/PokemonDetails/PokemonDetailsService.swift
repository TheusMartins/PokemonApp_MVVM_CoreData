//
//  PokemonDetailsService.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

protocol PokemonDetailsService {
    func getPokemon(pokemonName: String, completion: @escaping (PokemonDetailsModel?, Error?) -> Void)
}

//protocol PokemonDetailsCoreDataOperation {
//    func 
//}

class PokemonDetailsServiceImpl: PokemonDetailsService {
    typealias Target = PokemonDetailsTargetType
    
    private var provider: ProviderType<Target>
    
    init(provider: ProviderType<Target> = ProviderType<Target>()) {
        self.provider = provider
    }
    
    func getPokemon(pokemonName: String, completion: @escaping (PokemonDetailsModel?, Error?) -> Void) {
        provider.requestObject(model: PokemonDetailsModel.self, .getPokemonDetails(pokemonName)) { modelList, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(modelList, nil)
            }
        }
    }
}

