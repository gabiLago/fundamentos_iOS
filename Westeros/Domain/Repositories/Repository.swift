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


protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get } // Solo get, porque será de solo lectura.
    func house(named: String) -> House?
    func houses(filteredBy filter: HouseFilter) -> [House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
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
    
    // Type Safe Function doing same thing as :named
    enum enumHouses: String {
        case Stark
        case Lannister
        case Targaryen
    }
    
    func house(named name: enumHouses) -> House? {
        //let house = houses.filter{ $0.name == name }.first
        let house = houses.first{ $0.name == name.rawValue } // Con uppercase normalizamos los valores
        return house
    }
    
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
    
    // Adding Seasons and its Episodes
    var seasons: [Season] {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var seasonsArray = [Season]()
        var episodesArray = [Episode]()
        
        for season in gotSeasons {
            seasonsArray.append(Season(
                name: season.name,
                image: season.image,
                //releaseDate: dateFormatter.date(from: season.releaseDate)!)
                releaseDate: stringToDate(season.releaseDate)
                )
            )
        }
        
        for episode in gotEpisodes {
            
            let season = seasonsArray.first(where: {$0.name == episode.season})!
            let thisEpisode = (Episode(
                title: episode.title,
                //screeningDate: dateFormatter.date(from: episode.screeningDate)!,
                screeningDate: stringToDate(episode.screeningDate),
                synopsis: episode.synopsis,
                season: season
                )
            )
            
            season.add(episode: thisEpisode)
            episodesArray.append(thisEpisode)
            
        }
        return seasonsArray.sorted()
    }
    
    func seasons(filteredBy seasonFilter: (Season) -> Bool) -> [Season] {
        return seasons.filter(seasonFilter)
    }
    
}







