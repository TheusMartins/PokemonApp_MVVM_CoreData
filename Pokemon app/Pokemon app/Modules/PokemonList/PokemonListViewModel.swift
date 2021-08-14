//
//  PokemonListViewModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

final class PokemonListViewModel {
    //MARK: - Private properties
    private let pokemonGenerationRanges: [(limit: Int, offset: Int)] = [
        (limit: 151, offset: 0),
        (limit: 100, offset: 151),
        (limit: 135, offset: 251),
        (limit: 107, offset: 386),
        (limit: 156, offset: 493),
        (limit: 72, offset: 649),
        (limit: 88, offset: 721),
        (limit: 84, offset: 809)
    ]
    private var dataSource: [Pokemon] = []
    private let service: PokemonListService
    private let imageDownloader: DownloadImageViewModel
    
    //MARK: - Initialization
    init(
        service: PokemonListService = PokemonListServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel.shared
    ) {
        self.service = service
        self.imageDownloader = imageDownloader
    }
    
    //MARK: - Public methods
    func getPokemons(generationIndex: Int, completion: @escaping(_ error: Error?) -> Void) {
        let generation =  pokemonGenerationRanges[generationIndex]
        service.getPokemons(limit: generation.limit, offset: generation.offset) { [weak self] apiResponse in
            switch apiResponse {
            case .success(let pokemonList):
                self?.dataSource = pokemonList.results
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateInfos"), object: nil)
                completion(nil)
            case .failure(let error): completion(error)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    func getPokemonInfos(with index: Int) -> Pokemon {
        return dataSource[index]
    }
    
    func getPokemonName(at index: Int) -> String {
        return dataSource[index].name
    }
    
    func getImage(at index: Int, completion: @escaping(_ image: UIImage, _ hasError: Bool) -> Void) {
        let pokemonId = dataSource[index].url.absoluteString.split(whereSeparator: { $0 == "/"}).map(String.init).last
        imageDownloader.getPokemonImage(id: pokemonId ?? "") { apiResponse in
            switch apiResponse {
            case .success(let image): completion(image, false)
            case .failure: completion(UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), true)
            }
        }
    }
}
