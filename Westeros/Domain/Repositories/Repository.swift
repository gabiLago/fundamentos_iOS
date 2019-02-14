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
    var seasons: [Season] { get } // Solo get, porque será de solo lectura.
    func season(named: String) -> Season?
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
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
    
    var seasons: [Season] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dateString1 = "17/04/2011"
        let dateString2 = "24/04/2011"
        let dateString3 = "01/04/2012"
        let screeningDate1 = dateFormatter.date(from: dateString1)
        let screeningDate2 = dateFormatter.date(from: dateString2)
        let releaseDate1 = dateFormatter.date(from: dateString1)
        let releaseDate2 = dateFormatter.date(from: dateString3)
        let title1 = "Winter is Coming"
        let title2 = "The Kingsroad"
        let synopsis1 = "El rey [...] su ejército."
        let synopsis2 = "Tras aceptar su nuevo rol [...], Drogo."
        
        let season1 = Season(name: "Temporada 1", releaseDate: releaseDate1!)
        let season2 = Season(name: "Temporada 2", releaseDate: releaseDate2!)
        
        let episode1 = Episode(title: title1, screeningDate: screeningDate1!, synopsis: synopsis1, season: season1)
        let episode2 = Episode(title: title2, screeningDate: screeningDate2!, synopsis: synopsis2, season: season1)
        
        season1.add(episode: episode1)
        season2.add(episode: episode1)
        
        
        return [season1].sorted()
    }
    
    func season(named name: String) -> Season? {
        let season = seasons.first{ $0.name.uppercased() == name.uppercased() } // Con uppercase normalizamos los valores
        return season
    }
    
    func seasons(filteredBy seasonFilter: (Season) -> Bool) -> [Season] {
        return seasons.filter(seasonFilter)
    }
    
}







