//
//  DBPokemonManager.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import CoreData
import UIKit

final class DBPokemonManager {
    private let coreDataManager = CoreDataManager.shared
    
    func addPokemon(model: PokemonDetailsModel, frontImage: Data?, backImage: Data?) {
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
        pokemon.back = backImage
        
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
    }
    
    func isTeamCompleted() -> Bool {
        return getPokemons().count == 6
    }
}
