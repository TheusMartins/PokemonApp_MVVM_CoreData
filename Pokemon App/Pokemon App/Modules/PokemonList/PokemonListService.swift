//
//  PokemonListService.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

protocol PokemonListService {
    func getPokemons(completion: @escaping ([PokemonListModel]?, Error?) -> Void)
}

class PokemonListServiceImpl: PokemonListService {
    typealias Target = PokemonListTargetType
    
    private var provider: ProviderType<Target>
    
    init(provider: ProviderType<Target> = ProviderType<Target>()) {
        self.provider = provider
    }
    
    func getPokemons(completion: @escaping ([PokemonListModel]?, Error?) -> Void) {
        provider.requestArray(model: PokemonListModel.self, .getContacts) { modelList, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(modelList, nil)
            }
        }
    }
}
