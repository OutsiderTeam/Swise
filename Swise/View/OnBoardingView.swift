//
//  OnBoardingView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selectedTab = 0
    @State private var showHome = false
    
    @AppStorage("lastScreen") var lastScreen: String = ""
    
    @State var onBoardingItem = [
        OnBoarding(title: "Keep your sugar and calories on track!", description: "Start the healthy life style with  managing your sugar intake! ", icon: "confused_sugar"),
        OnBoarding(title: "Simple!", description: "Just input your meal, and we will calculate it for you!", icon: "smily_sugar"),
        OnBoarding(title: "Keep track of your calorie count", description: "Maintain your ideal calorie intake based on your needs using your BMI.", icon: "bowl")
    ]
    
    var body: some View {
        if lastScreen == "Health Checker" || showHome{
            if showHome{
                ExcerciseLevelView()
            }else{
                OnBoardingPageView(title: "Fill your health data", subtitle: "Please fill your health data in settings. Health data is for determine your ideal calorie intake based on your BMI.", icon: "bowl", selectedIndex: $selectedTab, showHome: $showHome)
            }
        } else {
            TabView(selection: $selectedTab) {
                ForEach(0..<onBoardingItem.count, id: \.self) { item in
                    OnBoardingPageView(title: onBoardingItem[item].title, subtitle: onBoardingItem[item].description, icon: onBoardingItem[item].icon, selectedIndex: $selectedTab, showHome: $showHome)
                        .tag(item)
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
