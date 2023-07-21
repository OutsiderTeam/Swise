//
//  ContentView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)
    @StateObject private var healthKitHelper = HealthKitHelper()
    @StateObject private var calculationViewModel  = DataCalculationViewModel()
    
    let optionsActivityIntensities = ["No Exercise", "Light", "Moderate (3-5 days/week)", "Very active (5-6 days/week)", "Very Active/Physical Job"]

    @State private var search: String = ""
    @State var isPresented: Bool = false
    @State var calNeed: Double = 0

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>

    var body: some View {
        NavigationStack {
            VStack {
                if search == "" {
                    List {
                        ForEach(items) { item in
                            
                            VStack {
                                HStack {
                                    Text("TotalSugar")
                                    Spacer()
                                    Text(item.totalSugar.description)
                                }
                                HStack {
                                    Text("TotalCalories")
                                    Spacer()
                                    Text(item.totalCalories.description)
                                }
                                Section(item.wrappedDate) {
                                    ForEach(item.eatenFoodsArray, id:\.self) { food in
                                        VStack {
                                            Text(food.wrappedFoodName)
                                            Text(food.wrappedFoodType)
                                            Text(food.servingFood?.servingDescription ?? "")
                                        }
                                    }
                                }

                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                } else {
                    if !viewModel.resultSearch.isEmpty {
                        List {
                            ForEach(viewModel.resultSearch, id: \.foodId) { food in
                                Text(food.foodName).onTapGesture {
                                    viewModel.getFood(id: Int(food.foodId)!)
                                    isPresented = true
                                }
                            }
                        }
                        .navigationDestination(isPresented: $isPresented) {
                            DetailFoodView(totalSugar: items.isEmpty ? 0 : items[0].totalSugar, totalCalories: items.isEmpty ? 0 : items[0].totalCalories )
                        }
                    }
                }
            }
            Spacer()
            
            // Select Activity Intensity for Calculate the calorie requirements
            VStack {
                    Section(header: Text("Select an Activity Intensity")) {
                        Picker(selection: $calculationViewModel.activityIntensity, label: Text("Option")) {
                            ForEach(optionsActivityIntensities, id: \.self) { option in
                                Text((option))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                Text("Activity Intensity: \(calculationViewModel.activityIntensity)")
            }

            Text("Height = \(Int(healthKitHelper.height))")
            Text("Weight = \(healthKitHelper.weight, specifier: "%.2f")")
            Text("Sex = \(healthKitHelper.sex)")
            Text("Age = \(healthKitHelper.age)")

            Text("Calorie Need = \(calculationViewModel.calorieNeed(), specifier: "%.f")")
            Text("Max Sugar Intake = \(calculationViewModel.calculateMaxSugar())")
            Text("Tea Spoon = \(calculationViewModel.calculateTeaSpoonOfSugar(calorie: calculationViewModel.calorieNeed()))")
            
        }
        .onAppear{
            healthKitHelper.requestAuthorization()
            
        }
        .onChange(of: healthKitHelper.healthApprove) { newValue in
            calculationViewModel.height = healthKitHelper.height
            calculationViewModel.age = Double(healthKitHelper.age)
            calculationViewModel.sex = healthKitHelper.sex
        }
        .environmentObject(viewModel)
        .searchable(text: $search)
        .onSubmit(of: .search) {
            viewModel.searchFood(query: search)
        }

    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
