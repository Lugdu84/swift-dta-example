//
//  ContentView.swift
//  ITour
//
//  Created by David Grammatico on 11/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // @Query(sort: \Destination.name) var destinations: [Destination]
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
            .navigationTitle("ITour")
            .navigationDestination(for: Destination.self, destination: { destination in
                EditDestination(destination: destination)
            })
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: Destination.self)
}
