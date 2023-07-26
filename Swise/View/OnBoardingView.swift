//
//  OnBoardingView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selectedTab = 0
    @State private var showHome = false
    
    @State private var showAlert = false
    
    @State var onBoardingItem = [
        OnBoarding(title: "Keep your sugar and calories on track!", description: "Start the healthy life style with  managing your sugar intake! ", icon: "confused_sugar"),
        OnBoarding(title: "Simple!", description: "Just input your meal, and we will calculate it for you!", icon: "smily_sugar"),
        OnBoarding(title: "Keep track of your calorie count", description: "Maintain your ideal calorie intake based on your needs using your BMI.", icon: "kcal_icon")
    ]
    
    var body: some View {
        if showHome {
            ExcerciseLevelView()
        } else {
            TabView(selection: $selectedTab) {
                ForEach(0..<onBoardingItem.count, id: \.self) { item in
                    StepsView(title: onBoardingItem[item].title, subtitle: onBoardingItem[item].description, icon: onBoardingItem[item].icon, selectedIndex: $selectedTab, showHome: $showHome, showAlert: $showAlert)
                        .tag(item)
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .alert("Fill your health data", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please fill your health data in settings. Health data is for determine your ideal calorie intake based on your BMI.")
            }
            
        }
    }
}

struct StepsView: View {
    var title: String
    var subtitle: String
    var icon: String
    @Binding var selectedIndex: Int
    @Binding var showHome: Bool
    @Binding var showAlert: Bool
    @StateObject private var healthKitHelper = HealthKitHelper()
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center){
                    
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210)
                    Text(title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.bottom,30)
                    
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Button {
                        if selectedIndex >= 2 {
                            if healthKitHelper.healthApprove{
                                calculationViewModel.height = healthKitHelper.height
                                calculationViewModel.age = Double(healthKitHelper.age)
                                calculationViewModel.sex = healthKitHelper.sex
                                print(healthKitHelper.height)
                            }else{
                                healthKitHelper.requestAuthorization()

                            }
                            
                        } else {
                            selectedIndex += 1
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.largeTitle).foregroundColor(.white)
                            .frame(width: 193, height: 71)
                            .background(Color("button_color"))
                            .cornerRadius(11)
                            .padding(.top,158)
                    }.padding(.bottom, 50)
                }.padding(.horizontal,15)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
            }
            .onChange(of: healthKitHelper.healthApprove) { newValue in
                if healthKitHelper.healthApprove{
                    calculationViewModel.height = healthKitHelper.height
                    calculationViewModel.age = Double(healthKitHelper.age)
                    calculationViewModel.sex = healthKitHelper.sex
                    
                }
            }
            .onChange(of: calculationViewModel.height) { newValue in
//                print(healthKitHelper.weight)
//                print(healthKitHelper.height)
//                print(calculationViewModel.height)
                print(calculationViewModel.age)
                print(calculationViewModel.sex)
                if calculationViewModel.healthChecker(){
                    
                    showHome = true
                } else {
                    showAlert = true
                }

            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
