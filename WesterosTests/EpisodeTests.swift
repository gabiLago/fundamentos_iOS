//
//  EpisodesTests.swift
//  WesterosTests
//
//  Created by Gabriel Lago Blasco on 12/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var dateString1, dateString2: String!
    let dateFormatter = DateFormatter()
    var screeningDate1, screeningDate2: Date!
    var title1, title2: String!
    var synopsis1, synopsis2: String!
    var episode1, cloneEpisode1, episode2: Episode!
    
    override func setUp() {
        dateString1 = "17/04/2011"
        dateString2 = "24/04/2011"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        screeningDate1 = dateFormatter.date(from: dateString1)
        screeningDate2 = dateFormatter.date(from: dateString2)
        
        title1 = "Winter is Coming"
        title2 = "The Kingsroad"
        
        synopsis1 = "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Ned Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia real en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército."
        
        synopsis2 = "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo."
        
        episode1 = Episode(title: title1, screeningDate: screeningDate1!, synopsis: synopsis1, season: "Temporada 1")
        
        cloneEpisode1 = Episode(title: title1, screeningDate: screeningDate1!, synopsis: synopsis1, season: "Temporada 1")
        
        episode2 = Episode(title: title2, screeningDate: screeningDate2!, synopsis: synopsis2, season: "Temporada 1")
    }
    
    override func tearDown() {
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
    }
    
    func testEpisodeIsHashable() {
        XCTAssertNotNil(episode1.hashValue)
        XCTAssertNotNil(episode2.hashValue)
    }
    
    func testEpisodeEquality(){
        //Identity
        XCTAssertEqual(episode1, episode1)
        
        // Equality
        XCTAssertEqual(episode1, cloneEpisode1)
        
        // Unequality
        XCTAssertNotEqual(episode1, episode2)
    }
    
    func testEpisodeIsComparable(){
         XCTAssertLessThan(episode1, episode2)
    }
    
    func testEpisodeHasCustomStringConvertible(){
        let testCustomString = "Nombre del episodio: \(episode1.title)"
        XCTAssertEqual(episode1.description, testCustomString)
    }
}


