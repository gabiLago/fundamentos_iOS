//
//  repositoryTests.swift
//  WesterosTests
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import XCTest
@testable import Westeros

class repositoryTests: XCTestCase {
    
    var houses: [House] = []
    var seasons: [Season] = []
    var episodes: [Episode] = []
    
    override func setUp() {
        houses = Repository.local.houses
        seasons = Repository.local.seasons
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepository_HouseCount() {
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepository_ReturnSortedArrayOfHouses() {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "stArk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    // Given - when - then
    func testLocalFactory_HousesFilteredBy_ReturnsTheCorrectValue() {
        let filtered = Repository.local.houses {
            $0.count == 1
        }
        XCTAssertEqual(filtered.count, 1 )
    }
    
    func testLocalRepositorySeasonExistence() {
        XCTAssertNotNil(seasons)
    }
    
    func testLocalRepository_SeasonCount() {
        XCTAssertEqual(seasons.count, 7)
    }
    
    func testLocalRepository_ReturnSortedArrayOfSeasons() {
        XCTAssertEqual(seasons, seasons.sorted())
    }
    
    func testLocalFactory_SeasonFilteredBy_ReturnsTheCorrectValue() {
        let filtered = Repository.local.seasons {
            $0.count == 10
        }
        XCTAssertEqual(filtered.count, 6 )
        // Test if 6 seasons has 10 episodes
    }
    
    func testLocalRepositoryReturnsHouseNamedThroughEnum() {
        let stark = Repository.local.house(named: LocalFactory.enumHouses.Stark)
        let lannister = Repository.local.house(named: LocalFactory.enumHouses.Lannister)
        XCTAssertNotNil(stark)
        XCTAssertNotEqual(lannister?.name, "Lonister")
        XCTAssertEqual(stark?.name, "Stark")
    }
}
