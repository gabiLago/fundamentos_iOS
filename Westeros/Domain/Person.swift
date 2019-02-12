//
//  Character.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: Properties
    let name: String
    private let _alias: String? // el _underscore es convención de propiedad privada
    let house: House
    
    // Variable computada
    var alias: String {
        return _alias ?? ""
    }
    
    //MARK: Initialization
    init(name: String, alias: String? = nil, house: House) { // valor por defecto de alias nil
        self.name = name
        _alias = alias
        self.house = house        
    }

    //    Me lo ahorro usando el valor por defecto en el init designado: Sting? = nil
    
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
    
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return fullName
    }
}

// Si dos personas tienen el mismo hash, significa que son iguales
// A la inversa no tiene porqué ser verdad: 2 objetos pueden ser iguales pero no tener el mismo hash
extension Person: Hashable {
    // Con proxy pasamos el marrón de calcular a otro objeto
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
