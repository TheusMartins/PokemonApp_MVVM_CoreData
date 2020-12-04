//
//  PokemonListService.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

protocol PokemonListService {
    func getPokemons(limit: Int, offset: Int, completion: @escaping (PokemonListModel?, Error?) -> Void)
}

final class PokemonListServiceImpl: PokemonListService {
    //MARK: - Typealias
    typealias Target = PokemonListTargetType
    
    //MARK: - Private properties
    private var provider: ProviderType<Target>
    
    //MARK: - Initialization
    init(provider: ProviderType<Target> = ProviderType<Target>()) {
        self.provider = provider
    }
    
    //MARK: - Public methods
    func getPokemons(limit: Int, offset: Int, completion: @escaping (PokemonListModel?, Error?) -> Void) {
        provider.requestObject(model: PokemonListModel.self, .getContacts(limit, offset)) { modelList, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(modelList, nil)
            }
        }
    }
}
