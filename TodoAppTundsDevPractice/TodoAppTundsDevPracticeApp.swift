//
//  TodoAppTundsDevPracticeApp.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/16/23.
//

import SwiftUI
import SwiftData

@main
struct TodoAppTundsDevPracticeApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
