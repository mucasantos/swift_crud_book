//
//  GenreSample.swift
//  MyBooks
//
//  Created by Samuel Santos on 17/04/24.
//

import Foundation

extension Genre {
    static var sampleGenres: [Genre]{
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non Fiction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000"),
        ]
    }
}
