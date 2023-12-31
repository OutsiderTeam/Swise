//
//  SummaryView.swift
//  Swise
//
//  Created by Mutiara Ruci on 17/07/23.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    @Namespace var namespace
    
    @State var progressValue: Float = 1
    @State var isPresented: Bool = false
    @State var isNavigateDiary: Bool = false
    @State var isNavigate: Bool = false
    @State var calNeed: Float = 0.0
    @State var data: [EatenFoods] = []
    @State var maxSugar: Int = 0
    @State var totalSugar: Double = 0
    @State var sugarCondition: Int = 0
    @State var selectedFYI: FYIModel = FYIModel(title: "", shortDesc: "", image: "", desc: [])
    @State var scrollOffset = CGFloat.zero
    @State var smallHeader: Bool = false
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "date == %@", Date().formatted(date: .complete, time: .omitted)),
        animation: .default)
    private var items: FetchedResults<DataItem>
    var body: some View {
        VStack(spacing: 0) {
            SummaryNavBarView(smallHeader: $smallHeader, isPresented: $isPresented, namespace: namespace)
            ObservableScrollView(scrollOffset: $scrollOffset, content: { proxy in
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
                                    Text("\(items.first?.totalSugar ?? 0, specifier: "%.f") gr / \(maxSugar) gr").font(.title3).bold()
                                    Text("sugar").font(.title3)
                                }
                                Text("Or equal to \(calculationViewModel.calculateTeaSpoonOfSugar(sugar: items.first?.totalSugar ?? 0)) teaspoon.").font(.body)
                                HStack {
                                    Image("spoon")
                                        .resizable()
                                        .frame(width: 46, height: 28)
                                    Text("x \(calculationViewModel.calculateTeaSpoonOfSugar(sugar: items.first?.totalSugar ?? 0))")
                                }
                            }
                            Spacer()
                            Image(sugarCondition == 0 ? "smily_sugar" : sugarCondition == 1 ? "panic_sugar" : "sad_sugar")
                                .resizable()
                                .frame(width: 107, height: 138)
                        }
                        if maxSugar == 50 {
                            Text("*Based on the ministry of health of Indonesia, 50 gr....").multilineTextAlignment(.leading).font(.body)
                        } else {
                            Text("*The sugar limit displayed may change depending on the calorie intake of the food you consume.").multilineTextAlignment(.leading).font(.body)
                        }
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
                        HStack(spacing: 10) {
                            ProgressBarView(progress: $progressValue, total: $calNeed)
                                .frame(width: 80.0, height: 80.0)
                                .padding(10.0)
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(items.first?.totalCalories ?? 0, specifier: "%.f") kcal/").fontWeight(.bold).foregroundColor(.black)
                                        .bold()
                                        .font(.title2)
                                    Text("\(calNeed, specifier: "%.f") kcal").font(.body)
                                }
                                
                                Text("*The results show a number of daily calories estimates that can be used as a guideline for maintain your weight.").foregroundColor(.black)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading).padding(.top, 5)
                            }.padding(.trailing, 15)
                            
                        }
                    }
                    .padding(12)
                    .frame(width: UIScreen.main.bounds.width - 40)
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
                            Button {
                                isNavigateDiary = true
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Show More")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 20)
                                }
                                .foregroundColor(Color.black)
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
                        HStack(alignment: .top) {
                            ForEach(FYIViewModel().fyi, id: \.id) {fyi in
                                Button {
                                    selectedFYI = fyi
                                    isNavigate = true
                                } label: {
                                    ZStack{
                                        VStack(alignment: .leading){
                                            Text(fyi.title)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, 9)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                            Text(fyi.shortDesc)
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }.padding()
                                    }
                                    .foregroundColor(Color.black)
                                    .frame(width: 169, height: 186)
                                    .background(Color("bg_yellow"))
                                    .cornerRadius(29)
                                }.shadow(color: .black.opacity(0.25), radius: 3, x: 1, y: 0)
                            }
                        }
                    }
                    
                }
                .onChange(of: scrollOffset, perform: { offset in
                    if offset < 100 {
                        withAnimation {
                            smallHeader = false
                        }
                    } else {
                        withAnimation {
                            smallHeader = true
                        }
                    }
                })
                //            .padding(.bottom, 100)
                .onAppear{
                    calculationViewModel.healthRequest()
                }
                .onChange(of: calculationViewModel.allFilled, perform: { _ in
                    data = items.first?.eatenFoodsArray ?? []
                    calNeed = Float(calculationViewModel.calorieNeed())
                    progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                    maxSugar = items.first?.totalCalories ?? 0 < Double(calNeed) ? calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0) : 50
                    totalSugar = items.first?.totalSugar ?? 0
                    sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
                })
                .onChange(of: calculationViewModel.height, perform: { _ in
                    calNeed = Float(calculationViewModel.calorieNeed())
                    progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                    maxSugar = items.first?.totalCalories ?? 0 < Double(calNeed) ? calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0) : 50
                    totalSugar = items.first?.totalSugar ?? 0
                    sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
                })
                .onChange(of: calculationViewModel.age, perform: { _ in
                    calNeed = Float(calculationViewModel.calorieNeed())
                    progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                    maxSugar = items.first?.totalCalories ?? 0 < Double(calNeed) ? calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0) : 50
                    totalSugar = items.first?.totalSugar ?? 0
                    sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
                })
                .onChange(of: calculationViewModel.sex, perform: { _ in
                    calNeed = Float(calculationViewModel.calorieNeed())
                    progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                    maxSugar = items.first?.totalCalories ?? 0 < Double(calNeed) ? calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0) : 50
                    totalSugar = items.first?.totalSugar ?? 0
                    sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
                })
                .onChange(of: calculationViewModel.weight, perform: { _ in
                    calNeed = Float(calculationViewModel.calorieNeed())
                    progressValue = Float((items.first?.totalCalories ?? 0) / calculationViewModel.calorieNeed())
                    maxSugar = items.first?.totalCalories ?? 0 < Double(calNeed) ? calculationViewModel.calculateMaxSugar(calorie: items.first?.totalCalories ?? 0) : 50
                    totalSugar = items.first?.totalSugar ?? 0
                    sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
                })
                .onChange(of: scenePhase, perform: { newValue in
                    if newValue == .active {
                        calculationViewModel.healthRequest()
                    }
                })
                .ignoresSafeArea(edges: .top)
                
            })
            
        }
        //            .onChange(of: items.first?.totalSugar ?? 0, perform: { newValue in
        //                maxSugar = calculationViewModel.calculateMaxSugar(calorie: newValue)
        //                totalSugar = items.first?.totalSugar ?? 0
        //                sugarCondition = totalSugar < Double(maxSugar) * 0.5 || (maxSugar == 0 && totalSugar == 0) ? 0 : totalSugar < Double(maxSugar) * 0.75 ? 1 : 2
        //            })
        .ignoresSafeArea(.all, edges: .top)
        .navigationDestination(isPresented: $isNavigate) {
            InformationView(fyiData: $selectedFYI)
        }
        .navigationDestination(isPresented: $isPresented) {
            AddFoodView(maxSugar: $maxSugar, calNeed: Double(calNeed))
        }
        .navigationDestination(isPresented: $isNavigateDiary) {
            HistoryView(isFoodDiary: true)
        }
        .navigationTitle("Summary")
        .toolbar(.hidden)
//        .ignoresSafeArea()
//        .edgesIgnoringSafeArea(.all)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
