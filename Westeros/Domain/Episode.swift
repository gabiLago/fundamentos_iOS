//
//  Episode.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 13/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

final class Episode {
    let title: String
    let screeningDate: Date
    let directedBy: String
    let writtenBy: String
    let synopsis: String
    weak var season: Season?
    
    init(title: String, screeningDate: Date, synopsis: String, directedBy: String, writtenBy:String, season: Season){
        self.title = title
        self.screeningDate = screeningDate
        self.directedBy = directedBy
        self.writtenBy = writtenBy
        self.synopsis = synopsis
        self.season = season
    }
}

extension Episode {
    var proxyEpisodeForEquality: String {
        return "\(title) \(screeningDate)"
    }
    
    var proxyEpisodeForComparison: Date {
        return screeningDate
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyEpisodeForEquality.hashValue
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyEpisodeForEquality == rhs.proxyEpisodeForEquality
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyEpisodeForComparison < rhs.proxyEpisodeForComparison
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "Nombre del episodio: \(title)"
    }
}
