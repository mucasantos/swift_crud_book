//
//  Book.swift
//  MyBooks
//
//  Created by Samuel Santos on 14/04/24.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String?
    @Relationship(deleteRule: .cascade)
    var quotes : [Quote]?
    @Relationship(inverse: \Genre.books)
    var genres: [Genre]?
    
    @Attribute(.externalStorage)
    var bookCover: Data?
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateCompleted = dateCompleted
        self.dateStarted = dateStarted
        self.summary = summary
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    
    var icon: Image{
        switch Status(rawValue: status)! {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In progress"
        case .completed:
            "Completed"
        }
    }
}
