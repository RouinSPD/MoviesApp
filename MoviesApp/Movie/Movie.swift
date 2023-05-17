//
//  Movie.swift
//  MoviesApp
//
//  Created by MacBook 28 on 17/02/23.
//

import Foundation

// create the structure of a movie with all the necessary information
struct Movie{
    var name : String
    var year : Int
    var duration : Int
    var director: String
    var isRestricted : Bool
    init(name: String, year: Int, duration: Int, director: String, isRestricted: Bool) {
        self.name = name
        self.year = year
        self.duration = duration
        self.director = director
        self.isRestricted = isRestricted
    }
}

