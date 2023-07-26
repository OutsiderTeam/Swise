//
//  DetailFoodView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 16/07/23.
//

import SwiftUI

struct DetailFoodView: View {
    @EnvironmentObject var viewModel: FoodViewModel
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel

    @Binding var maxSugar: Int
    @State var selectedIndex: Int = -1
    @State var calorieIntake: Double = 0
    @State var sugarIntake: Double = 0
    @State var sugarCondition: Double = 3
    @State var selectedServing: Serving = Serving(calcium: "", calories: "", carbohydrate: "", cholesterol: "", fat: "", fiber: "", iron: "", measurementDescription: "", metricServingAmount: "", metricServingUnit: "", monounsaturatedFat: "", numberOfUnits: "", polyunsaturatedFat: "", potassium: "", protein: "", saturatedFat: "", servingDescription: "", servingId: "", servingUrl: "", sodium: "", sugar: "", addedSugars: "", vitaminA: "", vitaminC: "", vitaminD: "", transFat: "")
    var totalSugar: Double = 0
    var totalCalories: Double = 0
    var calNeed: Double = 0
    var body: some View {
        VStack {
            if !viewModel.isLoading {
                Text(viewModel.food.foodName)
                if !viewModel.food.servings.serving!.isEmpty {
                    Picker("Serving", selection: $selectedIndex) {
                        ForEach(viewModel.food.servings.serving!.indices, id: \.self) { i in
                            Text(viewModel.food.servings.serving![i].servingDescription).tag(i)
                        }
                    }
                }
                if selectedServing.calories != "" && selectedServing.calories != nil {
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text(selectedServing.calories!)
                    }
                }
                if selectedServing.measurementDescription != "" && selectedServing.measurementDescription != nil {
                    HStack {
                        Text("Measurement Description")
                        Spacer()
                        Text(selectedServing.measurementDescription!)
                    }
                }
                if selectedServing.metricServingAmount != "" && selectedServing.metricServingAmount != nil {
                    HStack {
                        Text("Metric Serving Amount")
                        Spacer()
                        Text(selectedServing.metricServingAmount!)
                    }
                }
                if selectedServing.metricServingUnit != "" && selectedServing.metricServingUnit != nil {
                    HStack {
                        Text("Metric Serving Unit")
                        Spacer()
                        Text(selectedServing.metricServingUnit!)
                    }
                }
                if selectedServing.sugar != "" && selectedServing.addedSugars != nil {
                    HStack {
                        Text("Sugar")
                        Spacer()
                        Text(selectedServing.sugar!)
                    }
                }
                if selectedServing.addedSugars != "" && selectedServing.addedSugars != nil {
                    HStack {
                        Text("Added Sugars")
                        Spacer()
                        Text(selectedServing.addedSugars!)
                    }
                }
                if selectedServing.servingDescription != "" {
                    HStack {
                        Text("Serving Description")
                        Spacer()
                        Text(selectedServing.servingDescription)
                    }
                }
            }
        }
        .onChange(of: selectedIndex) { newValue in
            selectedServing = viewModel.food.servings.serving![selectedIndex]
            calorieIntake = totalCalories + (Double(viewModel.food.servings.serving![selectedIndex].calories ?? "0") ?? 0)
            sugarIntake = totalSugar + (Double(viewModel.food.servings.serving![selectedIndex].sugar ?? "0") ?? 0)
            maxSugar = calorieIntake < calNeed ? calculationViewModel.calculateMaxSugar(calorie: calorieIntake) : 50
            sugarCondition = sugarIntake < Double(maxSugar) * 0.5 || (maxSugar == 0 && sugarIntake == 0) ? 0 : sugarIntake < Double(maxSugar) * 0.75 ? 1 : 2
        }
        .toolbar {
            ToolbarItem {
                Button {
                    addEatenFood(food: viewModel.food, index: selectedIndex, totalSugar: sugarIntake, totalCalories: calorieIntake, sugarCondition: sugarCondition)
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
}

struct DetailFoodView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFoodView(maxSugar: .constant(0)).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
