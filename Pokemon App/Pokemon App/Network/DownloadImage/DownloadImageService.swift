//
//  DownloadImageService.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

protocol DownloadImageService {
    func getPokemon(url: URL, completion: @escaping (Data?, Error?) -> Void)
    func getPokemon(pokemonId: String, completion: @escaping (Data?, Error?) -> Void)
}

final class DownloadImageServiceImpl: DownloadImageService {
    //MARK: - Typealias
    typealias Target = DownloadImageTargetType
    
    //MARK: - Private properties
    private var provider: ProviderType<Target>
    
    //MARK: - Initialization
    init(provider: ProviderType<Target> = ProviderType<Target>()) {
        self.provider = provider
    }
    
    //MARK: - Public methods
    func getPokemon(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        provider.requestData(target: .getPokemonWithURL(url)) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
    }
    
    func getPokemon(pokemonId: String, completion: @escaping (Data?, Error?) -> Void) {
        provider.requestData(target: .getPokemonWithId(pokemonId)) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
    }
}


