//
//  DBPokemonManager.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import CoreData
import UIKit

final class DBPokemonManager {
    private let coreDataManager = CoreDataManager.shared
    
    func addPokemon(model: PokemonDetailsModel, frontImage: Data?) {
        
        for pokemon in getPokemons() {
            if pokemon.id == model.id {
                return
            }
        }
        
        guard getPokemons().count < 6 else { return }
        let pokemon = DBPokemon(context: coreDataManager.getContext())
        var type: [String] = []
        
        model.types.forEach { pokemonType in
            type.append(pokemonType.type.name)
        }
        
        pokemon.id = model.id
        pokemon.name = model.name
        pokemon.type = type
        pokemon.front = frontImage
        
        coreDataManager.saveContext()
    }
    
    func getPokemons() -> [DBPokemon] {
        let request: NSFetchRequest = DBPokemon.fetchRequest()
        
        do {
            var allPokemons: [DBPokemon] = []
            let pokemons = try coreDataManager.getContext().fetch(request)
            
            pokemons.forEach { pokemon in
                allPokemons.append(pokemon)
            }
            
            return allPokemons
        } catch  {
            fatalError()
        }
    }
    
    func deletePokemon(pokemonId: Int32) {
        let context = coreDataManager.getContext()
        let pokemon = getPokemons().first(where: { $0.id == pokemonId})
        guard let pokemonToBeDeleted = pokemon else { return }
        context.delete(pokemonToBeDeleted)
        coreDataManager.saveContext()
    }
    
    func canAddPokemon(pokemonId: Int32) -> Bool {
        let isPokemonAlreadyAdd = getPokemons().filter({ $0.id == pokemonId}).count > 0 ? true : false
        return getPokemons().count < 6 && !isPokemonAlreadyAdd
    }
}
