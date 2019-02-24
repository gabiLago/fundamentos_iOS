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
        
        for season in gotSeasons {
            seasonsArray.append(Season(
                name: season.name,
                image: season.image,
                releaseDate: stringToDate(season.releaseDate)
                )
            )
        }
        
        for episode in gotEpisodes {
            episodesArray.append(Episode(
                title: episode.title,
                screeningDate: stringToDate(episode.screeningDate),
                synopsis: episode.synopsis,
                directedBy: episode.directedBy,
                writtenBy: episode.writtenBy,
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
        XCTAssertEqual(seasonsArray.count, 7)
    }
    
    func testRandomEpisodeHasSeason() {
        XCTAssertNotNil(episodesArray[9].season)
    }
   }
