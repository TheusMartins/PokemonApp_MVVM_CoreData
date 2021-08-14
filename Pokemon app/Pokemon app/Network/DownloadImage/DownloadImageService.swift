//
//  DownloadImageService.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

protocol DownloadImageService {
    func getPokemon(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    func getPokemon(pokemonId: String, completion: @escaping (Result<Data, Error>) -> Void)
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
    func getPokemon(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        provider.requestData(target: .getPokemonWithURL(url)) { apiResponse in
            switch apiResponse {
            case .success(let imageData): completion(.success(imageData))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getPokemon(pokemonId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        provider.requestData(target: .getPokemonWithId(pokemonId)) { apiResponse in
            switch apiResponse {
            case .success(let imageData): completion(.success(imageData))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}


