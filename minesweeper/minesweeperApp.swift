//
//  minesweeperApp.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import SwiftUI

@main
struct minesweeperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
