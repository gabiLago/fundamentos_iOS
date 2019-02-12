//
//  House.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    
    // MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    // MARK: Initialization
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = wikiURL
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        // guard person.house.name == name else { return }
        // Refactor
        guard person.house == self else { return }
        
        _members.insert(person)
    }
    
    // Función variatica
    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
    }
}





extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForEquality
    }
}
