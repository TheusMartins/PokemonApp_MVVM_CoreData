//
//  PokemonDetailsViewModelTest.swift
//  Pokemon appTests
//
//  Created by Scizor on 12/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import XCTest
import Foundation
@testable import Pokemon_app

private class PokemonDetailsServiceMock: PokemonDetailsService, PokemonDetailsCoreDataOperations {
    var shouldThrowError = false
    var canAddPokemon = true
    var addPokemonCalls = 0
    let pokemon = PokemonDetailsModel(id: 1,
                                      name: "bulbasaur",
                                      sprites: PokemonSprites(
                                        front: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!,
                                        back: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")!),
                                      types: [
                                        PokemonType(type: Type(name: "grass"))
    ])
    
    func getPokemon(pokemonName: String, completion: @escaping (PokemonDetailsModel?, Error?) -> Void) {
        shouldThrowError ? completion(nil, NSError()) : completion(pokemon, nil)
    }
    
    func addPokemon(model: PokemonDetailsModel, imageData: Data?) {
        addPokemonCalls += 1
    }
    
    func canAddPokemon(pokemonId: Int32) -> Bool {
        return canAddPokemon
    }
}

final class PokemonDetailsViewModelTest: XCTestCase {
    private var sut: PokemonDetailsViewModel!
    private var service: PokemonDetailsServiceMock!
    private var imageDownloader: DownloadImageViewModel!
    private var imageDownloaderServiceMock: DownloadImageMock!
    
    override func setUp() {
        super.setUp()
        service = PokemonDetailsServiceMock()
        imageDownloaderServiceMock = DownloadImageMock()
        imageDownloader = DownloadImageViewModel(service: imageDownloaderServiceMock)
        sut = PokemonDetailsViewModel(service: service, imageDownloader: imageDownloader, pokemonName: "bulbasaur")
    }
    
    func testGetPokemonSuccess() {
        service.shouldThrowError = false
        var pokemonModel: PokemonDetailsModel? = nil
        sut.getPokemon { model in
            pokemonModel = model
        }
        
        XCTAssertTrue(pokemonModel != nil)
    }
    
    func testGetPokemonFailure() {
        service.shouldThrowError = true
        var pokemonModel: PokemonDetailsModel? = service.pokemon
        sut.getPokemon { model in
            pokemonModel = model
        }
        
        XCTAssertTrue(pokemonModel == nil)
    }
    
    func testAddPokemonSuccess() {
        service.canAddPokemon = true
        var actionMessage = ""
        sut.getPokemon { _ in }
        
        sut.addPokemon { feedbackMessage in
            actionMessage = feedbackMessage
        }
        
        XCTAssertTrue(service.addPokemonCalls == 1)
        XCTAssertTrue(actionMessage == "Pokemon successfully added")
    }
    
    func testAddPokemonFailure() {
        service.canAddPokemon = false
        var actionMessage = ""
        sut.getPokemon { _ in }
        
        sut.addPokemon { feedbackMessage in
            actionMessage = feedbackMessage
        }
        
        XCTAssertTrue(service.addPokemonCalls == 0)
        XCTAssertTrue(actionMessage == "Pokemon not added, your team is complete or you already have this pokemon in your team")
    }
    
    func testGetPokemonImageSuccess() {
        sut.getPokemon { _ in }
        imageDownloaderServiceMock.shouldThrowError = false
        var idSent = ""
        var imageIsNil: UIImage? = nil
        sut.getPokemonImage { [weak self] image, _ in
            idSent = self?.imageDownloaderServiceMock.urlSent ?? ""
            imageIsNil = image
        }
        
        
        XCTAssertTrue(imageIsNil != nil)
        XCTAssertTrue(idSent == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
    
    func testGetPokemonImageFailure() {
        sut.getPokemon { _ in }
        imageDownloaderServiceMock.shouldThrowError = true
        var hadError: Bool?
        sut.getPokemonImage { _, hasError in
            hadError = hasError
        }
        
        
        XCTAssertTrue(hadError == true)
    }
}
