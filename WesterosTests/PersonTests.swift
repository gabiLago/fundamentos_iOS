//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import XCTest
@testable import Westeros


class PersonTests: XCTestCase {

    var starkHouse: House! //(Opcional desempaquetado por huevos)
    var starkSigil: Sigil!
    // 1- Le damos un valor por defecto (y siempre tendría el mismo)
    // 2- La creo de tipo opcional, para que pueda ser nil, que es lo que está hecho en el setup y arriba
    
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Starck", sigil: starkSigil, words: "Winter is coming")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPersonExistence() {
        let character = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertNotNil(character)
    }
    
    func testPesonHasFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Starck")
    }

}
