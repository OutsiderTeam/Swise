//
//  TabView.swift
//  Swise
//
//  Created by Mutiara Ruci on 17/07/23.
//

import SwiftUI

struct TabNavView: View {
    var body: some View {
        TabView {
            // First Tab
            SummaryView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Summary")
                }
            
            // Second Tab
            Text("Second Tab")
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
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavView()
    }
}
