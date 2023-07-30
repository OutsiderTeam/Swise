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
    let persistenceController = PersistenceController.shared
    @StateObject private var dataCalculation = DataCalculationViewModel()
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)

    var body: some Scene {
        WindowGroup {
//            if lastScreen == "Main Screen"{
                SplashscreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataCalculation)
                .environmentObject(viewModel)
                    .preferredColorScheme(.light)
//            }else{
//                OnBoardingView().environmentObject(dataCalculation).preferredColorScheme(.light)
//            }
            
        }
    }
}
