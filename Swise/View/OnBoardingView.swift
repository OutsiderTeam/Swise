//
//  OnBoardingView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct OnBoardingView: View {
    //    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    @EnvironmentObject var persistenceController: PersistenceController
    
    @State private var selectedTab = 0
    @State private var showHome = false
    @State var isPresented: Bool = false
    
    @AppStorage("lastScreen") var lastScreen: String = ""
    //    let persistenceController = PersistenceController.shared
    @State var onBoardingItem = [
        OnBoarding(title: "Keep your sugar and calories on track!", description: "Start the healthy life style with  managing your sugar intake! ", icon: "confused_sugar"),
        OnBoarding(title: "Simple!", description: "Just input your meal, and we will calculate it for you!", icon: "smily_sugar"),
        OnBoarding(title: "Keep track of your calorie count", description: "Maintain your ideal calorie intake based on your needs using your BMI.", icon: "bowl")
    ]
    
    var body: some View {
        ZStack {
            if lastScreen == "Health Checker" || lastScreen == "Excercise"{
                if lastScreen == "Excercise"{
                    ExcerciseLevelView(isPresented: $isPresented)
                        .toolbar(.hidden)
                        .navigationBarBackButtonHidden()
                    
                }else{
                    NoFilledHealthView()
                        .toolbar(.hidden)
                        .navigationBarBackButtonHidden()
                    
                }
            } else if lastScreen != "Main Screen" {
                TabView(selection: $selectedTab) {
                    ForEach(0..<onBoardingItem.count, id: \.self) { item in
                        OnBoardingPageView(title: onBoardingItem[item].title, subtitle: onBoardingItem[item].description, icon: onBoardingItem[item].icon, selectedIndex: $selectedTab, showHome: $showHome)
                            .tag(item)
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .navigationDestination(isPresented: $isPresented) {
            TabNavView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
