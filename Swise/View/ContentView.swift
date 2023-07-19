//
//  ContentView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)
    @StateObject private var healthKitHelper = HealthKitHelper()

    @State private var search: String = ""
    @State var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            ListContentView(isPresented: $isPresented, search: $search)
                .searchable(text: $search)
                .onSubmit(of: .search) {
                    viewModel.searchFood(query: search)
                }
            Text("Height = \(healthKitHelper.height)")
            Text("Weight = \(healthKitHelper.weight)")
            Text("Sex = \(healthKitHelper.sex)")
            Text("Age = \(healthKitHelper.age)")
            
        }
        .onAppear{
            healthKitHelper.requestAuthorization()
        }
        .environmentObject(viewModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
