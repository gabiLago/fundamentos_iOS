//
//  Season.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 12/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

typealias SeasonEpisodes = Set<Episode>

final class Season {
    // MARK: Properties
    let name: String
    let image: String
    private var _episodes: SeasonEpisodes
    let releaseDate: Date
    
    // MARK: Initialization
    init(name: String, image: String, releaseDate: Date) {
        self.name = name
        self.image = image
        self.releaseDate = releaseDate
        _episodes = SeasonEpisodes()
    }
}

extension Season {
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
}

extension Season {
    var proxySeasonForEquatable: String {
        return name
    }
    
    var proxySeasonForComparison: Date {
        return releaseDate
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxySeasonForEquatable.hashValue
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxySeasonForComparison == rhs.proxySeasonForComparison
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxySeasonForComparison < rhs.proxySeasonForComparison
    }    
}

extension Season: CustomStringConvertible {
    var description: String {
        return "Nombre de la temporada: \(name)"
    }
}


extension Season {
    var count: Int {
        return _episodes.count
    }

    func add(episode: Episode) {

        _episodes.insert(episode)
    }
}

