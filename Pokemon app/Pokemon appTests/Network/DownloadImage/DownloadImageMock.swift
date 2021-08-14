//
//  DownloadImageMock.swift
//  Pokemon appTests
//
//  Created by Matheus Martins on 12/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation
@testable import Pokemon_app

final class DownloadImageMock: DownloadImageService {
    var shouldThrowError = false
    var idSent = ""
    var urlSent = ""
    
    func getPokemon(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSent = url.absoluteString
        shouldThrowError ? completion(.failure(NSError())) : completion(.success(Data()))
    }
    
    func getPokemon(pokemonId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        idSent = pokemonId
        shouldThrowError ? completion(.failure(NSError())) :
            completion(.success(Data()))
    }
}
