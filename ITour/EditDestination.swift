//
//  EditDestination.swift
//  ITour
//
//  Created by David Grammatico on 11/11/2023.
//

import SwiftUI
import SwiftData

struct EditDestination: View {
    @Bindable var destination: Destination
    @State private var newSightName = ""
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Détails", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight)
                        .disabled(newSightName.isEmpty)
                }
            }
        }
        .navigationTitle("Edit destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight()  {
        guard !newSightName.isEmpty else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Naples", details: "Aller à Naples")
        
        return EditDestination(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create a model container")
    }
   
}
