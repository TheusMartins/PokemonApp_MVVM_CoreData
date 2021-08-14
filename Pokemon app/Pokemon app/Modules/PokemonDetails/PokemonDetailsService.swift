//
//  PokemonDetailsService.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

protocol PokemonDetailsService {
    func getPokemon(pokemonName: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void)
}

protocol PokemonDetailsCoreDataOperations {
    func addPokemon(model: PokemonDetailsModel, imageData: Data?)
    func canAddPokemon(pokemonId: Int32) -> Bool
}

final class PokemonDetailsServiceImpl: PokemonDetailsService, PokemonDetailsCoreDataOperations {
    //MARK: - Tupealias
    typealias Target = PokemonDetailsTargetType
    
    //MARK: - Private properties
    private var provider: ProviderType<Target>
    private let coreDataManager: DBPokemonManager
    
    //MARK: - Initialization
    init(
        provider: ProviderType<Target> = ProviderType<Target>(),
        coreDataManager: DBPokemonManager = DBPokemonManager()
    ) {
        self.provider = provider
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Public methods
    func getPokemon(pokemonName: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void) {
        provider.requestObject(model: PokemonDetailsModel.self, .getPokemonDetails(pokemonName)) { apiResponse in
            switch apiResponse {
            case .success(let pokemonDetails): completion(.success(pokemonDetails))
            case .failure(let error): completion(.failure(error))
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

