//
//  PokemonTeamGeneralViewModelTest.swift
//  Pokemon appTests
//
//  Created by Scizor on 12/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import XCTest
import Foundation
@testable import Pokemon_app

private class PokemonTeamGeneralServiceMock: PokemonTeamGeneralService {
    func getAllPokemons() -> [DBPokemon] {
        return [
            DBPokemon(),
            DBPokemon()
        ]
    }
}

final class PokemonTeamGeneralViewModelTest: XCTestCase {
    private var sut: PokemonTeamGeneralViewModel!
    private var service: PokemonTeamGeneralServiceMock!
    
    override func setUp() {
        super.setUp()
        service = PokemonTeamGeneralServiceMock()
        sut = PokemonTeamGeneralViewModel(service: service)
    }
    
    func testGetAllLocalPokemons() {
        XCTAssertTrue(sut.getAllLocalPokemons().count == 2)
    }
}
