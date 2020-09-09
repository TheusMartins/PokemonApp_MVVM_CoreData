//
//  PokemonListViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonListViewModel {
    private var dataSource: [PokemonListModel] = []
    private let service: PokemonListService
    
    init(service: PokemonListService = PokemonListServiceImpl()) {
        self.service = service
    }
    
    func getPokemons(completion: @escaping() -> Void) {
        service.getPokemons { [weak self] modelList, error in
            guard let modelList = modelList else { return }
            self?.dataSource = modelList
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    func getPokemonInfos(with index: Int) -> Pokemon {
        return dataSource[index].results
    }
}

