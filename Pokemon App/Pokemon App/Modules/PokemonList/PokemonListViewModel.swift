//
//  PokemonListViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
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
    
    init(service: PokemonListService = PokemonListServiceImpl()) {
        self.service = service
        getPokemons { }
    }
    
    func getPokemons(limit: Int = 151, offset: Int = 0, completion: @escaping() -> Void) {
        service.getPokemons(limit: limit, offset: offset) { [weak self] modelList, error in
            guard let modelList = modelList else { return }
            self?.dataSource = modelList.results
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Teste"), object: nil)
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    func getPokemonInfos(with index: Int) -> Pokemon {
        return dataSource[index]
    }
}

extension PokemonListViewModel: PokemonGenerationPickerDelegate {
    func didClosePickerView(generationIndex: Int) {
        let generation =  pokemonGenerationRanges[generationIndex]
        getPokemons(limit: generation.limit, offset: generation.offset) { }
    }
}
