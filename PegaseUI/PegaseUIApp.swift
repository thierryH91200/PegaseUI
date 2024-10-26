//
//  PegaseUIApp.swift
//  PegaseUI
//
//  Created by Thierry hentic on 26/10/2024.
//

import SwiftUI

@main
struct PegaseUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
