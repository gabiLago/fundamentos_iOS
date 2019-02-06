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
        get {
            guard let alias = _alias else {
                return ""
            }
            return alias
        }
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

