//
//  ITourApp.swift
//  ITour
//
//  Created by David Grammatico on 11/11/2023.
//

import SwiftUI
import SwiftData

@main
struct ITourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
