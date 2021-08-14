//
//  PokemonDetailsViewModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//
import UIKit

final class PokemonDetailsViewModel {
    //MARK: - Private properties
    private let service: PokemonDetailsService & PokemonDetailsCoreDataOperations
    private let imageDownloader: DownloadImageViewModel
    private let pokemonName: String
    private var pokemonModel: PokemonDetailsModel?
    private var imageData: Data?
    
    //MARK: - Initialization
    init(
        service: PokemonDetailsService & PokemonDetailsCoreDataOperations = PokemonDetailsServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel.shared,
        pokemonName: String
    ) {
        self.service = service
        self.imageDownloader = imageDownloader
        self.pokemonName = pokemonName
    }
    
    //MARK: - Private methods
    private func setupErrorMessage() -> UIImage {
        guard let errorImage = UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate) else { return UIImage() }
        imageData = errorImage.pngData()
        return errorImage
    }
    
    //MARK: - Public methods
    func getPokemon(completion: @escaping(_ model: PokemonDetailsModel?) -> Void) {
        service.getPokemon(pokemonName: pokemonName) { [weak self] apiResponse in
            switch apiResponse {
            case .success(let pokemonDetails):
                self?.pokemonModel = pokemonDetails
                completion(pokemonDetails)
            case .failure: completion(nil)
            }
        }
    }
    
    func getPokemonImage(completion: @escaping(_ front: UIImage, _ hasError: Bool) -> Void) {
        guard let pokemonImageUrl = pokemonModel?.sprites.front else {
            completion(setupErrorMessage(), true)
            return
        }
        imageDownloader.getPokemonImage(url: pokemonImageUrl) { [weak self] apiResponse in
            guard let self = self else { return }
            switch apiResponse {
            case .success(let image):
                self.imageData = image.pngData()
                completion(image, false)
            case .failure: completion(self.setupErrorMessage(), true)
          }
        }
    }
    
    func addPokemon(completion: @escaping(_ feedbackMessage: String) -> Void) {
        guard let pokemon = pokemonModel else { return }
        if service.canAddPokemon(pokemonId: pokemon.id) {
            service.addPokemon(model: pokemon, imageData: imageData)
            completion("Pokemon successfully added")
        } else {
            completion("Pokemon not added, your team is complete or you already have this pokemon in your team")
        }
    }
}
