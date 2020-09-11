//
//  PokemonDetailsViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//
import UIKit

final class PokemonDetailsViewModel {
    private let service: PokemonDetailsService & PokemonDetailsCoreDataOperations
    private let imageDownloader: DownloadImageViewModel
    private let pokemonName: String
    private var pokemonModel: PokemonDetailsModel?
    private var imageData: Data?
    
    init(
        service: PokemonDetailsService & PokemonDetailsCoreDataOperations = PokemonDetailsServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel.shared,
        pokemonName: String
    ) {
        self.service = service
        self.imageDownloader = imageDownloader
        self.pokemonName = pokemonName
    }
    
    func getPokemon(completion: @escaping(_ model: PokemonDetailsModel) -> Void) {
        service.getPokemon(pokemonName: pokemonName) { [weak self] model, error in
            guard let model = model else { return }
            self?.pokemonModel = model
            completion(model)
        }
    }
    
    func getPokemonImage(completion: @escaping(_ front: UIImage, _ hasError: Bool) -> Void) {
        guard let pokemonModel = pokemonModel else { return }
        imageDownloader.getPokemonImage(url: pokemonModel.sprites.front) { [weak self] image, error in
            guard let image = image else {
                let errorImage = UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate)
                self?.imageData = errorImage?.pngData()
                completion(errorImage!, true)
                return
            }
            
            self?.imageData = image.pngData()
            completion(image, false)
        }
    }
    
    func addPokemon(completion: @escaping(_ feedbackMessage: String) -> Void) {
        guard let pokemon = pokemonModel else { return }
        if service.canAddPokemon() {
            service.addPokemon(model: pokemon, imageData: imageData)
            completion("Pokemon successfully added")
        } else {
            completion("Pokemon not added, your team is complete or you already have this pokemon in your team")
        }
    }
}
