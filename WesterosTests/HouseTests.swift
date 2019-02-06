//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León Rampante")
        
        starkHouse = House(name: "Starck", sigil: starkSigil, words: "Winter is coming")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rujido")
        
        robb = Person(name: "Robb", alias: "el joven lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
    }

    override func tearDown() {
        // Asignaríamos los objetos a nil
    }

    // Given - When - Then
    func testHouseExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        let stark = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        XCTAssertNotNil(starkSigil)
        
        let lannisterSigil = Sigil(image: UIImage(), description: "León Rampante")
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testHouseAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)

        XCTAssertEqual(starkHouse.count, 1)

        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion) //No debería de añadirse porque es de otra casa
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseEquality() {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Igualdad
        let jinxed = House(name: "Starck", sigil: starkSigil, words: "Winter is coming")
        XCTAssertEqual(starkHouse, jinxed)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
        
    }

    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse) 
    }
}
