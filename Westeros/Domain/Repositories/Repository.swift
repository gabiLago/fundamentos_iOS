//
//  Repository.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//


import UIKit

final class Repository {
    static let local = LocalFactory()
}

// MARK: Protocols
protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get } // Solo get, porque será de solo lectura.
    func house(named: String) -> House?
    func houses(filteredBy filter: HouseFilter) -> [House]
}

protocol ItemsFactory {
    typealias SeasonFilter = (Season) -> Bool
    var gotItem: (seasons: [Season], episodes: [Episode]) { get }
    func season(named: String) -> Season?
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
    func episodes(named: String) -> Episode?
}

final class LocalFactory: HouseFactory, ItemsFactory {
    
    var houses: [House] {
        // Creación de casas
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Logo Huargo")
        let lanninsterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragón tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lanninsterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        // Añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Dannerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        return [targaryenHouse, starkHouse, lannisterHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        //let house = houses.filter{ $0.name == name }.first
        let house = houses.first{ $0.name.uppercased() == name.uppercased() } // Con uppercase normalizamos los valores
        return house
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
    
    // Adding Seasons and its Episodes
    var gotItem: (seasons: [Season], episodes: [Episode]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var seasonsArray = [Season]()
        var episodesArray = [Episode]()

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
        
        return (seasons: seasonsArray, episodes: episodesArray)
        
        
    }
    
    func season(named name: String) -> Season? {
        let season = gotItem.seasons.first{ $0.name.uppercased() == name.uppercased() } // Con uppercase normalizamos los valores
        return season
    }
    
    func seasons(filteredBy seasonFilter: (Season) -> Bool) -> [Season] {
        return gotItem.seasons.filter(seasonFilter)
    }
    
    func episodes(named title: String) -> Episode? {
        let episode = gotItem.episodes.first{ $0.title.uppercased() == title.uppercased() } // Con uppercase normalizamos los valores
        return episode
    }
    
}







