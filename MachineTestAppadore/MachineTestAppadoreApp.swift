//
//  MachineTestAppadoreApp.swift
//  MachineTestAppadore
//
//  Created by Nishay Kumar on 25/02/25.
//

import SwiftUI

@main
struct MachineTestAppadoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
