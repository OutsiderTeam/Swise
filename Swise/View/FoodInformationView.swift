//
//  FoodInformationView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI
import SkeletonUI

struct FoodInformationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: FoodViewModel
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    
    @Binding var maxSugar: Int
    @State var selectedIndex: Int = -1
    @State var calorieIntake: Double = 0
    @State var sugarIntake: Double = 0
    @State var sugarCondition: Double = 3
    @State var status: Bool = false
    @State var message: String = ""
    @State var selectedServing: Serving = Serving(calcium: "", calories: "", carbohydrate: "", cholesterol: "", fat: "", fiber: "", iron: "", measurementDescription: "", metricServingAmount: "", metricServingUnit: "", monounsaturatedFat: "", numberOfUnits: "", polyunsaturatedFat: "", potassium: "", protein: "", saturatedFat: "", servingDescription: "", servingId: "", servingUrl: "", sodium: "", sugar: "", addedSugars: "", vitaminA: "", vitaminC: "", vitaminD: "", transFat: "")
    var totalSugar: Double = 0
    var totalCalories: Double = 0
    var calNeed: Double = 0
    let persistenceController = PersistenceController.shared

    var body: some View {
        NavigationView {
            CustomNavBarContainerView(isSearch: false) {
//                VStack(){
                    // Form for details of the new food
                    VStack(alignment: .leading){
                        Text("\(viewModel.food.foodName)")
                            .font(.title2)
                            .bold()
                        VStack(alignment: .leading) {
                            HStack {
                                HStack {
                                    Text("Servings")
                                    Spacer()
                                }.frame(maxWidth: UIScreen.main.bounds.width*0.4)
                                if !viewModel.food.servings.serving!.isEmpty {
                                    Picker("Serving", selection: $selectedIndex) {
                                        ForEach(viewModel.food.servings.serving!.indices, id: \.self) { i in
                                            Text(" \(viewModel.food.servings.serving![i].servingDescription) ").tag(i)
                                        }
                                    }.accentColor(.blue)

                                }
                            }
                            HStack {
                                HStack {
                                    Text("Added Sugar")
                                    Spacer()
                                }.frame(maxWidth: UIScreen.main.bounds.width*0.4)
                                if selectedServing.sugar != "" && selectedServing.addedSugars != nil {
                                    Text(": \(selectedServing.sugar!) gr").bold()
                                } else {
                                    Text(": 0 gr").bold()
                                }
                            }
                            HStack {
                                HStack {
                                    Text("Amount Calories")
                                    Spacer()
                                }.frame(maxWidth: UIScreen.main.bounds.width*0.4)
                                if selectedServing.calories != "" && selectedServing.calories != nil {
                                    Text(": \(selectedServing.calories!) kcal").bold()
                                } else {
                                    Text(": 0 kcal").bold()
                                }
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: UIScreen.main.bounds.width-40)
                    .background(Color("bg_yellow"))
                    .cornerRadius(29)
                    .skeleton(with: viewModel.isLoading, size: CGSize(width: UIScreen.main.bounds.width-40, height: 200))
                    .shape(type: .rounded(.radius(20, style: .circular)))
                    .animation(type: .linear())
                    
//                }.padding(.horizontal, 20)
                // Button for take an action to add new food
                ZStack {
                    VStack {
                        Spacer()
                        Button(
                            action: {
                                message = persistenceController.addEatenFood(food: viewModel.food, index: selectedIndex, totalSugar: sugarIntake, totalCalories: calorieIntake, sugarCondition: sugarCondition)
                                status = true
                            }){
                                HStack{
                                    Text("Done")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }.foregroundColor(.white).frame(width: UIScreen.main.bounds.width-40, height: 48).background(Color("button_color")).cornerRadius(11)
                                
                            }
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                            .padding()
                    }
                }
            }
        }
        .alert(isPresented: $status) {
            Alert(title: Text(message == "Your food sucessfully added" ? "Success" : "Error"), message: Text(message), dismissButton: .default(Text("OK"), action: {
                if message == "Your food sucessfully added" {
                    presentationMode.wrappedValue.dismiss()
                }
            }))
        }
        .onChange(of: selectedIndex) { newValue in
            selectedServing = viewModel.food.servings.serving![selectedIndex]
            calorieIntake = totalCalories + (Double(viewModel.food.servings.serving![selectedIndex].calories ?? "0") ?? 0)
            sugarIntake = totalSugar + (Double(viewModel.food.servings.serving![selectedIndex].sugar ?? "0") ?? 0)
            maxSugar = calorieIntake < calNeed ? calculationViewModel.calculateMaxSugar(calorie: calorieIntake) : 50
            sugarCondition = sugarIntake < Double(maxSugar) * 0.5 || (maxSugar == 0 && sugarIntake == 0) ? 0 : sugarIntake < Double(maxSugar) * 0.75 ? 1 : 2
            
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
