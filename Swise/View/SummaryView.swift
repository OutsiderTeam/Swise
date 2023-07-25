//
//  SummaryView.swift
//  Swise
//
//  Created by Mutiara Ruci on 17/07/23.
//

import SwiftUI

struct SummaryView: View {
    @StateObject private var healthKitHelper = HealthKitHelper()
    @StateObject private var calculationViewModel  = DataCalculationViewModel()

    @State var progressValue: Float = 1
    @State var isPresented: Bool = false
    @State var calNeed: Float = 0.0
    @State var data: [EatenFoods] = []
    @State var maxSugar: Int = 0
    @State var totalSugar: Double = 0
    @State var sugarCondition: Int = 0
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "date == %@", Date().formatted(date: .complete, time: .omitted)),
        animation: .default)
    private var items: FetchedResults<DataItem>
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Hi user!").font(.largeTitle)
                        Spacer()
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .background(Color("bg_blue"))
                            .clipShape(Circle())
                    }.padding(.top, 20)
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            HStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("What have you eaten today?").font(.headline).fontWeight(.semibold)
                                    Text("Add your meal now!").font(.headline).fontWeight(.semibold)
                                }
                                Image("bowl")
                                    .resizable()
                                    .frame(width: 77, height: 84)
                            }
                            Button {
                                isPresented = true
                            } label: {
                                VStack {
                                    Text("Add your meal").foregroundColor(.white)
                                }
                                .padding(.vertical, 12)
                                .frame(width: UIScreen.main.bounds.width-40)
                                .background(Color("button_color"))
                                .cornerRadius(11)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
                .background(Color("bg_blue"))
                .cornerRadius(30)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Sugar Intake Calculation").font(.title3).bold()
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("You’ve consumed").font(.body)
                                HStack {
                                    Text("\(items.first?.totalSugar ?? 0, specifier: "%.f") gr / \(items.first?.totalCalories ?? 0 > Double(calNeed) ? 50 : maxSugar) gr").font(.title3).bold()
                                    Text("sugar").font(.title3)
                                }
                                Text("Or equal to \(calculationViewModel.calculateTeaSpoonOfSugar(calorie: items.first?.totalCalories ?? 0)) teaspoon.").font(.body)
                                HStack {
                                    Image("spoon")
                                        .resizable()
                                        .frame(width: 46, height: 28)
                                    Text("x \(calculationViewModel.calculateTeaSpoonOfSugar(calorie: items.first?.totalCalories ?? 0))")
                                }
                            }
                            Spacer()
                            Image(sugarCondition == 0 ? "smily_sugar" : sugarCondition == 1 ? "panic_sugar" : "sad_sugar")
                                    .resizable()
                                    .frame(width: 107, height: 138)
                        }
                        Text("*Based on the ministry of health of Indonesia, 50 gr....").multilineTextAlignment(.leading)
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .frame(width: UIScreen.main.bounds.width-40, alignment: .top)
                    .background(sugarCondition == 0 ? Color("bg_green") : sugarCondition == 1 ? Color("bg_orange") : Color("bg_red"))
                    .cornerRadius(30)
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                VStack {
                    HStack {
                        Text("Calorie Count")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    ZStack{
                        HStack{
                            ProgressBarView(progress: $progressValue, total: $calNeed)
                                .frame(width: 80.0, height: 80.0)
                                .padding(30.0)
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(items.first?.totalCalories ?? 0, specifier: "%.f") kcal/").fontWeight(.bold).foregroundColor(.black)
                                        .bold()
                                        .font(.title2)
                                    Text("\(calNeed, specifier: "%.f") kcal").font(.body)
                                }
                                
                                Text("*Based on your BMI, your max. calorie intake is \(calNeed, specifier: "%.f") kcal").foregroundColor(.black)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading).padding(.top, 5)
                            }.padding(.trailing, 15)
                            
                        }
                    }
                    .frame(width: 359, height: 124)
                    .background(Color("bg_blue"))
                    .cornerRadius(29)
                    
                    VStack{
                        HStack {
                            Text("Your Food Diary")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    if data.count > 0 {
                        ForEach(0..<(data.count <= 3 ? data.count : 3), id: \.self) { i in
                            FoodItemView(name: data[i].foodName ?? "-", calories: data[i].servingFood?.calories ?? "0", sugar: data[i].servingFood?.sugar ?? "0", serving: data[i].servingFood?.servingDescription ?? "-")
                        }
                        if data.count > 3 {
                            HStack {
                                Spacer()
                                Text("Show More")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 20)
                            }
                        }
                    } else {
                        EmptyListView()
                    }
                    VStack{
                        HStack {
                            Text("For Your Information")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ZStack{
                                VStack(alignment: .leading){
                                    Text("What is BMI?")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("Do you know BMI is a measure if your weight is healthy or not.")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }.padding()
                            }
                            .frame(width: 169, height: 186)
                            .background(Color("bg_yellow"))
                            .cornerRadius(29)
                            ZStack{
                                VStack(alignment: .leading){
                                    Text("What is BMI?")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("Do you know BMI is a measure if your weight is healthy or not.")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }.padding()
                            }
                            .frame(width: 169, height: 186)
                            .background(Color("bg_yellow"))
                            .cornerRadius(29)
                            ZStack{
                                VStack(alignment: .leading){
                                    Text("What is BMI?")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("Do you know BMI is a measure if your weight is healthy or not.")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }.padding()
                            }
                            .frame(width: 169, height: 186)
                            .background(Color("bg_yellow"))
                            .cornerRadius(29)
                            ZStack{
                                VStack(alignment: .leading){
                                    Text("What is BMI?")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("Do you know BMI is a measure if your weight is healthy or not.")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }.padding()
                            }
                            .frame(width: 169, height: 186)
                            .background(Color("bg_yellow"))
                            .cornerRadius(29)
                        }
                    }
                }
            }
            .padding(.bottom, 100)
            .onAppear{
                healthKitHelper.requestAuthorization()
                data = items.first?.eatenFoodsArray ?? []
                progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                maxSugar = calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0)
                totalSugar = items.first?.totalSugar ?? 0
                sugarCondition = totalSugar < Double(maxSugar) * 0.5 ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
            }
            .onChange(of: healthKitHelper.healthApprove) { newValue in
                calculationViewModel.height = healthKitHelper.height
                calculationViewModel.age = Double(healthKitHelper.age)
                calculationViewModel.sex = healthKitHelper.sex
                calNeed = Float(calculationViewModel.calorieNeed())
                progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                maxSugar = calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0)
                sugarCondition = totalSugar < Double(maxSugar) * 0.5 ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
            }
            .onChange(of: items.first?.totalSugar ?? 0, perform: { newValue in
                maxSugar = calculationViewModel.calculateMaxSugar(calorie: newValue)
                totalSugar = items.first?.totalSugar ?? 0
            })
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isPresented) {
                AddFoodView()
            }
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func getscreenBound() -> CGRect{
        return UIScreen.main.bounds
    }
}
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
