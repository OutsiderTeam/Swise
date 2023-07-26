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
    @StateObject private var dataCalculation = DataCalculationViewModel()

    var body: some Scene {
        WindowGroup {
//            TabNavView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            OnBoardingView().environmentObject(dataCalculation)
            
        }
    }
}
