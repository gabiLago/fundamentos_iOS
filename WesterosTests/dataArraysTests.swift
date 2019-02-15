//
//  dataArraysTests.swift
//  WesterosTests
//
//  Created by Gabriel Lago Blasco on 15/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import XCTest

@testable import Westeros



class dataArraysTests: XCTestCase {
   
    var seasonsArray = [Season]()
    var episodesArray = [Episode]()
    
    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for season in gotSeasons {
            seasonsArray.append(Season(
                name: season.name,
                releaseDate: dateFormatter.date(from: season.releaseDate)!)
            )
        }
        
        for episode in gotEpisodes {
            episodesArray.append(Episode(
                title: episode.title,
                screeningDate: dateFormatter.date(from: episode.screeningDate)!,
                synopsis: episode.synopsis,
                season: seasonsArray.first(where: {$0.name == episode.season})!)
            )
        }
    }

    override func tearDown() {        
    }

    func testRandomSeasonInArrayExistence() {
        XCTAssertNotNil(seasonsArray[3].name)
    }
    
    func testDataArrayHasAllValues() {
        XCTAssertEqual(seasonsArray.count, 8)
    }
    
    func testRandomEpisodeHasSeason() {
        XCTAssertNotNil(episodesArray[9].season)
    }
   
    

}
