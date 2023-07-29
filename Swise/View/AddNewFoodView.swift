//
//  AddNewFood.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 21/07/23.
//

import SwiftUI

struct AddNewFoodView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var viewModel: FoodViewModel
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel

    @Binding var maxSugar: Int
    @State var food: FoodDetail = FoodDetail(brandName: "", foodId: "\(UUID())", foodName: "", foodType: "manual", foodUrl: "", servings: Servings(serving: []))
    @State var serving: Serving = Serving(calcium: "", calories: "", carbohydrate: "", cholesterol: "", fat: "", fiber: "", iron: "", measurementDescription: "", metricServingAmount: "", metricServingUnit: "", monounsaturatedFat: "", numberOfUnits: "", polyunsaturatedFat: "", potassium: "", protein: "", saturatedFat: "", servingDescription: "", servingId: "", servingUrl: "", sodium: "", sugar: "", addedSugars: "", vitaminA: "", vitaminC: "", vitaminD: "", transFat: "")
    @State private var foodName: String = ""
    @State private var sugarAdded: String = ""
    @State private var calories: String = ""
    @State private var servingName: String = ""
    @State var calorieIntake: Double = 0
    @State var sugarIntake: Double = 0
    @State var sugarCondition: Double = 3
    @State var isPresented: Bool = false
    @State var isError: Bool = false
    @State var isSuccess: Bool = false
    var totalSugar: Double = 0
    var totalCalories: Double = 0
    var calNeed: Double = 0

    var body: some View {
        NavigationView {
            CustomNavBarContainerView(isSearch: false) {
                VStack(alignment: .leading){
                    if isError {
                        VStack {
                            HStack {
                                Text("Please fill out all data!").foregroundColor(.red).font(.headline)
                            }
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                            .background(Color("bg_yellow"))
                            .cornerRadius(12)
                        }.padding(.top, 20)
                    }
                    // Form for details of the new food
                    Form {
                        Section{
                            HStack(alignment: .top){
                                HStack {
                                    Text("Food Name")
                                    Spacer()
                                }.frame(width: (UIScreen.main.bounds.width-40)/2).frame(alignment: .leading)
                                TextField("Food name",text: $foodName)
                            }.listRowBackground(Color("bg_yellow").padding(.bottom,3))
                            Group {
                                HStack{
                                    HStack {
                                        Text("Added Sugar")
                                        Spacer()
                                    }.frame(width: (UIScreen.main.bounds.width-40)/2).frame(alignment: .leading)
                                    TextField("0",text: $sugarAdded).keyboardType(.numberPad)
//                                    Spacer()
                                    Text("grams")
                                }
                                
                                HStack{
                                    HStack {
                                        Text("Amount Calories")
                                        Spacer()
                                    }.frame(width: (UIScreen.main.bounds.width-40)/2).frame(alignment: .leading)
                                    TextField("0",text: $calories).keyboardType(.numberPad)
                                    Text("kcal")
                                }
                            }.listRowBackground(Color("bg_yellow").padding(.vertical,3))
                                HStack{
                                    HStack {
                                    Text("Serving Size")
                                    Spacer()
                                }.frame(width: (UIScreen.main.bounds.width-40)/2).frame(alignment: .leading)

                                TextField("1 bowl",text: $servingName)
                            }.listRowBackground(Color("bg_yellow").padding(.top,3))
                        }
                        .listRowSeparator(.hidden)
                        .onChange(of: sugarAdded) { newValue in
                            let tmpSugar = Double(newValue)
                            sugarIntake = totalSugar + (tmpSugar ?? 0)
                        }
                        
                    }.scrollContentBackground(.hidden)
                    
                    // Button for take an action to add new food
                    Button(
                        action: {
                            if foodName == "" || calories == "" || servingName == "" {
                                isError = true
                            } else {
                                isError = false
                                sugarIntake = totalSugar + (Double(sugarAdded) ?? 0)
                                calorieIntake = totalCalories + (Double(calories) ?? 0)
                                maxSugar = calorieIntake < calNeed ? calculationViewModel.calculateMaxSugar(calorie: calorieIntake) : 50
                                sugarCondition = sugarIntake < Double(maxSugar) * 0.5 || (maxSugar == 0 && sugarIntake == 0) ? 0 : sugarIntake < Double(maxSugar) * 0.75 ? 1 : 2
                                food.foodName = foodName
                                food.brandName = ""
                                food.foodId = ""
                                food.foodType = "manually"
                                food.foodUrl = ""
                                serving.sugar = sugarAdded
                                serving.calories = calories
                                serving.servingDescription = servingName
                                food.servings.serving?.append(serving)
                                isSuccess = addEatenFood(food: food, index: -1, totalSugar: sugarIntake, totalCalories: calorieIntake, sugarCondition: sugarCondition)
                            }
                        }){
                            HStack{
                                Text("Add food")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-40, height: 50)
                            .background(Color("button_color"))
                            .cornerRadius(11)
                            
                        }
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                        .padding()
                }
                .alert(isPresented: $isSuccess) {
                    Alert(title: Text("Success"), message: Text("Success add food to eaten food"), dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                }

            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Add New Food")
        
    }
}

struct AddNewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFoodView(maxSugar: .constant(0)).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
