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
    
    var dateString1, dateString2, dateString3: String!
    let dateFormatter = DateFormatter()
    var screeningDate1, screeningDate2, releaseDate1, releaseDate2: Date!
    var title1, title2: String!
    var synopsis1, synopsis2: String!
    var episode1, cloneEpisode1, episode2: Episode!
    var season1, season2: Season!
    
    override func setUp() {
        dateString1 = "17/04/2011"
        dateString2 = "24/04/2011"
        dateString3 = "01/04/2012"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        screeningDate1 = dateFormatter.date(from: dateString1)
        screeningDate2 = dateFormatter.date(from: dateString2)
        releaseDate1 = dateFormatter.date(from: dateString1)
        releaseDate2 = dateFormatter.date(from: dateString3)
        
        season1 = Season(name: "Temporada 1", releaseDate: releaseDate1!)
        season2 = Season(name: "Temporada 2", releaseDate: releaseDate2!)
        
        title1 = "Winter is Coming"
        title2 = "The Kingsroad"
        
        synopsis1 = "El rey [...] su ejército."
        synopsis2 = "Tras aceptar su nuevo rol [...], Drogo."
        
        episode1 = Episode(title: title1, screeningDate: screeningDate1!, synopsis: synopsis1, season: season1)
        cloneEpisode1 = Episode(title: title1, screeningDate: screeningDate1!, synopsis: synopsis1, season: season1)
        episode2 = Episode(title: title2, screeningDate: screeningDate2!, synopsis: synopsis2, season: season1)
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
        let testCustomString2 = "Nombre del episodio: \(episode2.title)"
        XCTAssertEqual(episode2.description, testCustomString2)
    }
}


