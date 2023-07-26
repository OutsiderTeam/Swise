//
//  SwiseApp.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import SwiftUI

@main
struct SwiseApp: App {
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            TabNavView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
