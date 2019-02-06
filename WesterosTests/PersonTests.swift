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

    var ned: Person!
    var arya: Person!
    var starkHouse: House! //(Opcional desempaquetado por huevos)
    var starkSigil: Sigil!
    // 1- Le damos un valor por defecto (y siempre tendría el mismo)
    // 2- La creo de tipo opcional, para que pueda ser nil, que es lo que está hecho en el setup y arriba
    
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Starck", sigil: starkSigil, words: "Winter is coming")
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPersonExistence() {
        XCTAssertNotNil(ned)
    }
    
    func testPesonHasFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Starck")
    }

    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(ned, ned)
        
        // Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        
        // Desigualdada
        XCTAssertNotEqual(ned, arya)
    }
}
