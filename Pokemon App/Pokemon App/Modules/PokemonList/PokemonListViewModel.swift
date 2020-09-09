//
//  PokemonListViewModel.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

final class PokemonListViewModel {
    private var dataSource: [Pokemon] = []
    private var filteredList: [Pokemon] = []
    private let service: PokemonListService
    
    init(service: PokemonListService = PokemonListServiceImpl()) {
        self.service = service
    }
    
    func getPokemons(completion: @escaping() -> Void) {
        service.getPokemons { [weak self] modelList, error in
            guard let modelList = modelList else { return }
            self?.dataSource = modelList.results
            self?.filteredList = modelList.results
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        return filteredList.count
    }
    
    func getPokemonInfos(with index: Int) -> Pokemon {
        return filteredList[index]
    }
    
    func getListFiltered(with sting: String, completion: @escaping() -> Void) {
        let filter = dataSource.filter { $0.name.lowercased().contains(sting.lowercased())}
        filteredList = sting == "" ? dataSource : filter
        completion()
    }
}

