//
//  EditBookView.swift
//  MyBooks
//
//  Created by Samuel Santos on 15/04/24.
//

import SwiftUI

struct EditBookView: View {
    @Environment (\.dismiss) private var dismiss
    
    let book: Book
    
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    @State private var recommendedBy = ""
    var body: some View {
        HStack{
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                    
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading){
            GroupBox {
                LabeledContent{
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                }label: {
                    Text("Date added")
                }
                if status == .inProgress || status == .completed{
                    LabeledContent{
                        DatePicker("", selection: $dateStarted, displayedComponents: .date)
                    }label: {
                        Text("Date Started")
                    }
                }
                
                if status == .completed{
                    LabeledContent{
                        DatePicker("", selection: $dateCompleted, displayedComponents: .date)
                    }label: {
                        Text("Date Completed")
                    }
                }
            }
            
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView{
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    }else if newValue == .inProgress && oldValue == .completed{
                        //from completed to inProgress
                        dateCompleted = Date.distantPast
                    }else if newValue == .inProgress && oldValue == .onShelf{
                        //Book has been started
                        dateStarted = Date.now
                    }else if newValue == .completed && oldValue == .onShelf{
                        //forgot to start book
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    }else{
                        //completed
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent{
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            }label: {
                Text("Rating")
            }
            LabeledContent{
                TextField("", text: $title)
            }label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent{
                TextField("", text: $author)
            }label: {
                Text("Author").foregroundStyle(.secondary)
            }
            LabeledContent{
                TextField("", text: $recommendedBy)
            }label: {
                Text("Recommended by").foregroundStyle(.secondary)
            }
            Divider()
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $summary)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke( Color(uiColor: .tertiaryLabel), lineWidth: 2))
            NavigationLink {
                QuotesListView(book: book)
            }label: {
                let count = book.quotes?.count ?? 0
                Label("^[\(count) Quotes](inflect: true)", systemImage: "quote.opening")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            .padding(.horizontal)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if changed {
                Button("Update"){
                    book.status = status.rawValue
                    book.rating = rating
                    book.title = title
                    book.author = author
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateCompleted
                    book.recommendedBy = recommendedBy
                    dismiss()
                }.buttonStyle(.borderedProminent)
            }
        }
        .onAppear{
            status = Status(rawValue: book.status)!
            rating = book.rating
            title = book.title
            author = book.author
            summary = book.summary
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateCompleted = book.dateCompleted
            recommendedBy = book.recommendedBy ?? ""
        }
    }
    var changed: Bool {
        status != Status(rawValue: book.status)!
      ||  rating != book.rating
      ||  title != book.title
      ||  author != book.author
      ||  summary != book.summary
      ||  dateAdded != book.dateAdded
       || dateStarted != book.dateStarted
       ||  dateCompleted != book.dateCompleted
        || recommendedBy != book.recommendedBy
    }
}

#Preview {
    let preview = Preview(Book.self)
 return   NavigationStack{
     EditBookView(book: Book.sampleBooks[4])
         .modelContainer(preview.container)
    }
}
