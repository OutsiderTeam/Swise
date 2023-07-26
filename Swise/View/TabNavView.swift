//
//  TabView.swift
//  Swise
//
//  Created by Mutiara Ruci on 17/07/23.
//

import SwiftUI

struct TabNavView: View {
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)
    var body: some View {
            TabView {
                // First Tab
                SummaryView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Summary")
                    }.toolbarBackground(Color.white, for: .tabBar)
                
                // Second Tab
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("History")
                    }
                
                // Third Tab
                
                Text("Second Tab")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }.environmentObject(viewModel).accentColor(Color("button_color"))
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavView()
    }
}
