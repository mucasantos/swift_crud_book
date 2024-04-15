//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Samuel Santos on 14/04/24.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
    
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
