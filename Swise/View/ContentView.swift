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
    @StateObject private var calculationViewModel  = DataCalculationViewModel()

    @State private var search: String = ""
    @State var isPresented: Bool = false
    @State var calNeed: Double = 0

    var body: some View {
        NavigationStack {
            ListContentView(isPresented: $isPresented, search: $search)
                .searchable(text: $search)
                .onSubmit(of: .search) {
                    viewModel.searchFood(query: search)
                }
            Spacer()
            
            // Select Activity Intensity for Calculate the calorie requirements
            VStack {
                    Section(header: Text("Select an Activity Intensity")) {
                        Picker(selection: $calculationViewModel.activityIntensity, label: Text("Option")) {
                            ForEach(Activity.allCases) { activity in
                                Text((activity.rawValue)).tag(activity)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                Text("Activity Intensity: \(calculationViewModel.activityIntensity.rawValue)")
            }

            Text("Height = \(Int(calculationViewModel.height))")
            Text("Weight = \(calculationViewModel.weight, specifier: "%.2f")")
            Text("Sex = \(calculationViewModel.sex.rawValue)")
            Text("Age = \(calculationViewModel.age)")

            Text("Calorie Need = \(calculationViewModel.calorieNeed(), specifier: "%.f")")
            Text("Max Sugar Intake = \(calculationViewModel.calculateMaxSugar(calorie: 10))")
            Text("Tea Spoon = \(calculationViewModel.calculateTeaSpoonOfSugar(sugar: calculationViewModel.calorieNeed()))")
            
        }
        .onAppear{
            calculationViewModel.healthRequest()
            
        }
//        .onChange(of: healthKitHelper.healthApprove) { newValue in
//            calculationViewModel.height = healthKitHelper.height
//            calculationViewModel.age = Double(healthKitHelper.age)
//            calculationViewModel.sex = healthKitHelper.sex
//        }
        .environmentObject(viewModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
