//
//  PokemonListViewModel.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

final class PokemonListViewModel {
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
    
    init(
        service: PokemonListService = PokemonListServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel.shared
    ) {
        self.service = service
        self.imageDownloader = imageDownloader
    }
    
    func getPokemons(generationIndex: Int, completion: @escaping(_ error: Error?) -> Void) {
        let generation =  pokemonGenerationRanges[generationIndex]
        service.getPokemons(limit: generation.limit, offset: generation.offset) { [weak self] modelList, error in
            guard let modelList = modelList else {
                completion(error)
                return
            }
            self?.dataSource = modelList.results
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateInfos"), object: nil)
            completion(nil)
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
        imageDownloader.getPokemonImage(id: pokemonId ?? "") { image, error in
            guard let image = image else {
                let errorImage = UIImage(named: "notFoundImage")?.withRenderingMode(.alwaysTemplate)
                completion(errorImage!, true)
                return
            }
            
            completion(image, false)
        }
    }
}
