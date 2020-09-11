//
//  PokemonDetailsService.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation

protocol PokemonDetailsService {
    func getPokemon(pokemonName: String, completion: @escaping (PokemonDetailsModel?, Error?) -> Void)
}

protocol PokemonDetailsCoreDataOperations {
    func addPokemon(model: PokemonDetailsModel, imageData: Data?)
    func canAddPokemon(pokemonId: Int32) -> Bool
}

class PokemonDetailsServiceImpl: PokemonDetailsService, PokemonDetailsCoreDataOperations {
    typealias Target = PokemonDetailsTargetType
    
    private var provider: ProviderType<Target>
    let coreDataManager: DBPokemonManager
    
    init(
        provider: ProviderType<Target> = ProviderType<Target>(),
        coreDataManager: DBPokemonManager = DBPokemonManager()
    ) {
        self.provider = provider
        self.coreDataManager = coreDataManager
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
    
    func addPokemon(model: PokemonDetailsModel, imageData: Data?) {
        return coreDataManager.addPokemon(model: model, frontImage: imageData)
    }
    
    func canAddPokemon(pokemonId: Int32) -> Bool {
        return coreDataManager.canAddPokemon(pokemonId: pokemonId)
    }
}

