//
//  Sigil.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

final class Sigil {
    
    // MARK: Properties
    let description: String
    let image: UIImage
    
    // MARK: Initialization
    init(image: UIImage, description: String) {
        self.description = description
        self.image = image
    }
    
}
