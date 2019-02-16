//
//  dateFormatter.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 16/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import Foundation

func dateToString(_ date: Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    return dateFormatter.string(from: date)
}

func stringToDate(_ date: String) -> Date{
 
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    return dateFormatter.date(from: date)!
}
