//
//  FoodInformationView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct FoodInformationView: View {
    @State private var foodName: String = "Plain Cheeseburger"
    @State private var sugarAdded: String = "12 gr"
    @State private var calories: String = "202 kcal"
    @State private var servingName: String = "1 Portion"
    
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
        NavigationView {
            VStack{
                // Form for details of the new food
                if !viewModel.isLoading {
                    Form {
                        Section{
                            Text("\(viewModel.food.foodName)").font(.title2).bold()
                            HStack{
                                Text("Servings")
                                if !viewModel.food.servings.serving!.isEmpty {
                                    Picker("Serving", selection: $selectedIndex) {
                                        ForEach(viewModel.food.servings.serving!.indices, id: \.self) { i in
                                            Text(" \(viewModel.food.servings.serving![i].servingDescription) ").tag(i)
                                                .bold().padding(.leading,108)
                                        }
                                    }
                                }
                            }
                            
                                HStack{
                                    Text("Added Sugar")
                                    if selectedServing.sugar != "" && selectedServing.addedSugars != nil {
                                        Text(": \(selectedServing.sugar!) ").bold().padding(.leading,75)
                                    } else {
                                        Text(": 0 ").bold().padding(.leading,75)
                                    }
                                }
                            
                            
                                HStack{
                                    Text("Amount Calories")
                                    if selectedServing.calories != "" && selectedServing.calories != nil {
                                    Text(": \(selectedServing.calories!)").bold().padding(.leading,48)
                                    }else{
                                        Text(": ").bold().padding(.leading,48)
                                    }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        
                        
                    }.padding(-20)
                        .background(Color("bg_blue"))
                        .frame(width: 350, height: 202)
                        .cornerRadius(29)
                        .scrollContentBackground(.hidden)
                    Spacer()
                }
                // Button for take an action to add new food
                Button(
                    action: {
                        addEatenFood(food: viewModel.food, index: selectedIndex, totalSugar: sugarIntake, totalCalories: calorieIntake, sugarCondition: sugarCondition)
                    }){
                        HStack{
                            Text("Done")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }.foregroundColor(.white).frame(width: 261, height: 48).background(Color("button_color")).cornerRadius(11)
                        
                    }.padding()
            }
            .onChange(of: selectedIndex) { newValue in
                selectedServing = viewModel.food.servings.serving![selectedIndex]
                calorieIntake = totalCalories + (Double(viewModel.food.servings.serving![selectedIndex].calories ?? "0") ?? 0)
                sugarIntake = totalSugar + (Double(viewModel.food.servings.serving![selectedIndex].sugar ?? "0") ?? 0)
                maxSugar = calorieIntake < calNeed ? calculationViewModel.calculateMaxSugar(calorie: calorieIntake) : 50
                sugarCondition = sugarIntake < Double(maxSugar) * 0.5 || (maxSugar == 0 && sugarIntake == 0) ? 0 : sugarIntake < Double(maxSugar) * 0.75 ? 1 : 2
            }
            
        }
        .navigationTitle("New Food")
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView(maxSugar: .constant(0)).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
