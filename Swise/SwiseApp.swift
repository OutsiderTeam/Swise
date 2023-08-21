//
//  SwiseApp.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import SwiftUI

@main
struct SwiseApp: App {
    @AppStorage("lastScreen") var lastScreen: String = ""
    @StateObject private var persistenceController = PersistenceController.shared
    @StateObject private var dataCalculation = DataCalculationViewModel()
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)
    
    var body: some Scene {
        WindowGroup {
            SplashscreenView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(persistenceController)
                .environmentObject(dataCalculation)
                .environmentObject(viewModel)
                .preferredColorScheme(.light)
        }
    }
}
