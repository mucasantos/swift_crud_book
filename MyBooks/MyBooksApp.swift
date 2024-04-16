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
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container)
    }
    
    init(){
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        }catch{ fatalError("Could not configure the container")}
        
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        }catch
//        {
//            fatalError("Could not configure the container")
//        }
        
        print(URL.documentsDirectory.path())
        //print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
