//
//  DownloadImageViewModelTest.swift
//  Pokemon appTests
//
//  Created by Matheus Martins on 12/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import XCTest
import Foundation
@testable import Pokemon_app

final class DownloadImageViewModelTest: XCTestCase {
    private var sut: DownloadImageViewModel!
    private var service: DownloadImageMock!
    
    override func setUp() {
        super.setUp()
        service = DownloadImageMock()
        sut = DownloadImageViewModel(service: service)
    }
    
    func testGetPokemonImageIdSuccess() {
        service.shouldThrowError = false
        var hasError: Bool = true
        var idSent: String?
        sut.getPokemonImage(id: "1") { [weak self] response in
            idSent = self?.service.idSent
            switch response {
            case .success: hasError = false
            case .failure: hasError = true
            }
        }
        
        XCTAssertTrue(hasError == false)
        XCTAssertTrue(idSent == "1.png")
    }
    
    func testGetPokemonImageIdFailure() {
        service.shouldThrowError = true
        var hasError: Bool = false
        sut.getPokemonImage(id: "1") { response in
            switch response {
            case .success: hasError = false
            case .failure: hasError = true
            }
        }
        
        XCTAssertTrue(hasError == true)
    }
    
    func testGetPokemonImageUrlSuccess() {
        service.shouldThrowError = false
        var hasError: Bool = true
        var idSent: String?
        sut.getPokemonImage(url: URL(string: "google.com")!) { [weak self] response in
            idSent = self?.service.urlSent
            switch response {
            case .success: hasError = false
            case .failure: hasError = true
            }
        }
        
        XCTAssertTrue(hasError == false)
        XCTAssertTrue(idSent == "google.com")
    }
    
    func testGetPokemonImageUrlFailure() {
        service.shouldThrowError = true
        var hasError: Bool = false
        sut.getPokemonImage(url: URL(string: "google.com")!) { response in
            switch response {
            case .success: hasError = false
            case .failure: hasError = true
            }
        }
        
        XCTAssertTrue(hasError == true)
    }
}
