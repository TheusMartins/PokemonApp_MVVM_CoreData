//
//  DownloadImage.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class DownloadImageViewModel {
    private let service: DownloadImageService
    static var shared = DownloadImageViewModel()
    
    init(service: DownloadImageService = DownloadImageServiceImpl()) {
        self.service = service
    }
    
    func getPokemonImage(id: String, completion: @escaping (UIImage?, Error?) -> Void) {
        service.getPokemon(pokemonId: "\(id).png") { data, error in
            guard let imageData = data else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }
            
            let image = UIImage(data: imageData)
            completion(image, nil)
        }
    }
    
    func getPokemonImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        service.getPokemon(url: url) { data, error in
            guard let imageData = data else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }
            
            let image = UIImage(data: imageData)
            completion(image, nil)
        }
    }
}

