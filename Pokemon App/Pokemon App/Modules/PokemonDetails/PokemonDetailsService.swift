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

protocol PokemonDetailsCoreDataOperations {
    func addPokemon(model: PokemonDetailsModel)
    func canAddPokemon() -> Bool
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
    
    func addPokemon(model: PokemonDetailsModel) {
        return coreDataManager.addPokemon(model: model, frontImage: nil, backImage: nil)
    }
    
    func canAddPokemon() -> Bool {
        return !coreDataManager.isTeamCompleted()
    }
}

