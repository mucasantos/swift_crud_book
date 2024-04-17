//
//  Quote.swift
//  MyBooks
//
//  Created by Samuel Santos on 16/04/24.
//

import Foundation
import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    
    init(text: String, page: String? = nil){
        self.text = text
        self.page = page
    }
    //Relation
    
    var book: Book?
}

