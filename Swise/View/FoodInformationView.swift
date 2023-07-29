//
//  FoodInformationView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct FoodInformationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: FoodViewModel
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    
    @Binding var maxSugar: Int
    @State var selectedIndex: Int = -1
    @State var calorieIntake: Double = 0
    @State var sugarIntake: Double = 0
    @State var sugarCondition: Double = 3
    @State var isSuccess: Bool = false
    @State var selectedServing: Serving = Serving(calcium: "", calories: "", carbohydrate: "", cholesterol: "", fat: "", fiber: "", iron: "", measurementDescription: "", metricServingAmount: "", metricServingUnit: "", monounsaturatedFat: "", numberOfUnits: "", polyunsaturatedFat: "", potassium: "", protein: "", saturatedFat: "", servingDescription: "", servingId: "", servingUrl: "", sodium: "", sugar: "", addedSugars: "", vitaminA: "", vitaminC: "", vitaminD: "", transFat: "")
    var totalSugar: Double = 0
    var totalCalories: Double = 0
    var calNeed: Double = 0
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView(isSearch: false) {
                
                
                VStack(){
                    // Form for details of the new food
//                    if !viewModel.isLoading {
                        VStack(alignment: .leading){
                            Text("\(viewModel.food.foodName)").font(.title2).bold()
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Servings")
                                    Spacer()
                                    if !viewModel.food.servings.serving!.isEmpty {
                                        Picker("Serving", selection: $selectedIndex) {
                                            ForEach(viewModel.food.servings.serving!.indices, id: \.self) { i in
                                                Text(" \(viewModel.food.servings.serving![i].servingDescription) ").tag(i)
                                            }
                                        }.accentColor(.blue)
                                        
                                    }
                                }
                                
                                HStack{
                                    Text("Added Sugar")
                                    if selectedServing.sugar != "" && selectedServing.addedSugars != nil {
                                        Text(": \(selectedServing.sugar!) ").bold().padding(.leading,98)
                                    } else {
                                        Text(": 0 ").bold().padding(.leading, 98)
                                    }
                                }.padding(.top,1)
                                
                                
                                
                                HStack{
                                    Text("Amount Calories")
                                    if selectedServing.calories != "" && selectedServing.calories != nil {
                                        Text(": \(selectedServing.calories!)").bold().padding(.leading,71)
                                    }else{
                                        Text(": ").bold().padding(.leading,71)
                                    }
                                }.padding(.top,1)
                            }
                        }.padding()
                            .padding(.vertical, 10)
                            .background(Color("bg_yellow"))
                            .cornerRadius(29)
                            .padding(30)
                        
                        Spacer()
//                    }
                    // Button for take an action to add new food
                    Button(
                        action: {
                            isSuccess = addEatenFood(food: viewModel.food, index: selectedIndex, totalSugar: sugarIntake, totalCalories: calorieIntake, sugarCondition: sugarCondition)
                        }){
                            HStack{
                                Text("Done")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }.foregroundColor(.white).frame(width: UIScreen.main.bounds.width-40, height: 48).background(Color("button_color")).cornerRadius(11)
                            
                        }
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                        .padding()
                }.padding()
                
            }
            .alert(isPresented: $isSuccess) {
                Alert(title: Text("Success"), message: Text("Success add food to eaten food"), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }))
            }
            .onChange(of: selectedIndex) { newValue in
                selectedServing = viewModel.food.servings.serving![selectedIndex]
                calorieIntake = totalCalories + (Double(viewModel.food.servings.serving![selectedIndex].calories ?? "0") ?? 0)
                sugarIntake = totalSugar + (Double(viewModel.food.servings.serving![selectedIndex].sugar ?? "0") ?? 0)
                maxSugar = calorieIntake < calNeed ? calculationViewModel.calculateMaxSugar(calorie: calorieIntake) : 50
                sugarCondition = sugarIntake < Double(maxSugar) * 0.5 || (maxSugar == 0 && sugarIntake == 0) ? 0 : sugarIntake < Double(maxSugar) * 0.75 ? 1 : 2
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("New Food")
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView(maxSugar: .constant(0)).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
