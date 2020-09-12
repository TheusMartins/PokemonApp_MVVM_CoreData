//
//  PokemonViewModelTest.swift
//  Pokemon appTests
//
//  Created by Matheus Martins on 12/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import XCTest
import Foundation
@testable import Pokemon_app

private class PokemonServiceMock: PokemonService {
    var removeFromTeamCalls = 0
    func removeFromTeam(id: Int32) {
        removeFromTeamCalls += 1
    }
}

final class PokemonViewModelTest: XCTestCase {
    private var sut: PokemonViewModel!
    private var service: PokemonServiceMock!
    
    override func setUp() {
        super.setUp()
        service = PokemonServiceMock()
        sut = PokemonViewModel(service: service, pokemon: PokemonModel(id: 1, name: "bulbasaur", imageData: nil, types: ["grass"]))
    }
    
    func testRemovePokemonFromTeam() {
        var message: String?
        sut.removePokemonFromTeam { feedbackMessage in
            message = feedbackMessage
        }
        
        XCTAssertTrue(service.removeFromTeamCalls == 1)
        XCTAssertTrue(message == "Bulbasaur has been removed from your team")
    }
    
    func testGetPokemonName() {
        XCTAssertTrue(sut.getPokemonName() == "bulbasaur")
    }
}

