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
    @AppStorage("lastScreen") var lastScreen: String = ""

    
    var body: some Scene {
        WindowGroup {
            if lastScreen == "Main Screen"{
                TabNavView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(dataCalculation)
            }else{
                OnBoardingView().environmentObject(dataCalculation)
            }
            
        }
    }
}
