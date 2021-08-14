//
//  PokemonListViewModelTest.swift
//  Pokemon appTests
//
//  Created by Matheus Martins on 12/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import XCTest
import Foundation
@testable import Pokemon_app

private class PokemonListServiceMock: PokemonListService {
    var shouldThrowError = false
    let pokemonlist = PokemonListModel(results: [
        Pokemon(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!),
        Pokemon(name: "ivysaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/2/")!),
        Pokemon(name: "venusaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/3/")!)
    ])
    
    func getPokemons(limit: Int, offset: Int, completion: @escaping (Result<PokemonListModel, Error>) -> Void) {
        shouldThrowError ? completion(.failure(NSError())) : completion(.success(pokemonlist))
    }
}

final class PokemonListViewModelTest: XCTestCase {
    private var sut: PokemonListViewModel!
    private let imageDownloaderService = DownloadImageMock()
    private let service = PokemonListServiceMock()
    
    override func setUp() {
        super.setUp()
        sut = PokemonListViewModel(service: service, imageDownloader: DownloadImageViewModel(service: imageDownloaderService))
    }
    
    func testGetNumberOfRows() {
        sut.getPokemons(generationIndex: 0) { _ in }
        XCTAssertTrue(sut.getNumberOfRows() == 3)
    }
    
    func testGetPokemonInfos() {
        sut.getPokemons(generationIndex: 0) { _ in }
        XCTAssertEqual(sut.getPokemonInfos(with: 0).name, service.pokemonlist.results[0].name)
        XCTAssertEqual(sut.getPokemonInfos(with: 0).url, service.pokemonlist.results[0].url)
    }
    
    func testGetPokemonName() {
        sut.getPokemons(generationIndex: 0) { _ in }
        XCTAssertTrue(sut.getPokemonName(at: 0) == "bulbasaur")
    }
    
    func testGetImageSuccess() {
        sut.getPokemons(generationIndex: 0) { _ in }
        imageDownloaderService.shouldThrowError = false
        var idSent = ""
        var imageIsNil: UIImage? = nil
        sut.getImage(at: 1) { [weak self] image, _ in
            idSent = self?.imageDownloaderService.idSent ?? ""
            imageIsNil = image
        }
        
        
        XCTAssertTrue(imageIsNil != nil)
        XCTAssertTrue(idSent == "2.png")
    }
    
    func testGetImageFailure() {
        sut.getPokemons(generationIndex: 0) { _ in }
        imageDownloaderService.shouldThrowError = true
        var hadError: Bool?
        sut.getImage(at: 0) { _, hasError in
            hadError = hasError
        }
        
        
        XCTAssertTrue(hadError == true)
    }
    
    func testGetPokemonsSuccess() {
        service.shouldThrowError = false
        var hasErrors = true
        sut.getPokemons(generationIndex: 0) { error in
            if error == nil {
                hasErrors = false
            }
        }
        
        XCTAssertTrue(hasErrors == false)
    }
    
    func testGetPokemonsFailure() {
        service.shouldThrowError = true
        var hasErrors = false
        sut.getPokemons(generationIndex: 0) { error in
            if error != nil {
                hasErrors = true
            }
        }
        
        XCTAssertTrue(hasErrors == true)
        XCTAssertTrue(sut.getNumberOfRows() == 0)
    }
}
