//
//  OnBoardingPageView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 27/07/23.
//

import SwiftUI

struct OnBoardingPageView: View {
    var title: String
    var subtitle: String
    var icon: String
    @Binding var selectedIndex: Int
    @Binding var showHome: Bool
    @Binding var showAlert: Bool
    @StateObject private var healthKitHelper = HealthKitHelper()
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    
    @AppStorage("lastScreen") var lastScreen: String = ""
    
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
                        if selectedIndex == 2 {
                            if !healthKitHelper.healthApprove{
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
            .onChange(of: healthKitHelper.height, perform: { newValue in
                calculationViewModel.height = healthKitHelper.height
                calculationViewModel.age = Double(healthKitHelper.age)
                calculationViewModel.sex = healthKitHelper.sex
                if calculationViewModel.healthChecker(){
//                    lastScreen = "Excercise Screen"
                    showHome = true
                } else {
                    lastScreen = "Health Checker"
//                    showAlert = true
                }

            })
        }
    }
}


