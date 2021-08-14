//
//  DownloadImage.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

final class DownloadImageViewModel {
    //MARK: - Static properties
    static var shared = DownloadImageViewModel()
    
    //MARK: - Private properties
    private let service: DownloadImageService
    
    //MARK: - Initialization
    init(service: DownloadImageService = DownloadImageServiceImpl()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func getPokemonImage(id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        service.getPokemon(pokemonId: "\(id).png") { apiResponse in
            switch apiResponse {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(.success(UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate) ?? UIImage()))
                    return
                }
                completion(.success(image))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getPokemonImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        service.getPokemon(url: url) { apiResponse in
            switch apiResponse {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(.success(UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate) ?? UIImage()))
                    return
                }
                completion(.success(image))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

