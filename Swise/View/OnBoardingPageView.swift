//
//  OnBoardingPageView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 27/07/23.
//

import SwiftUI
import HealthKit

struct OnBoardingPageView: View {
    var title: String
    var subtitle: String
    var icon: String
    @Binding var selectedIndex: Int
    @Binding var showHome: Bool
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
                        if lastScreen == "Health Checker"{
                        } else {
                            if selectedIndex == 2 {
                                calculationViewModel.healthRequest()
                            } else {
                                selectedIndex += 1
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.largeTitle).foregroundColor(.white)
                            .frame(width: 193, height: 71)
                            .background(Color("button_color"))
                            .cornerRadius(11)
                            .padding(.top,158)
                    }.padding(.bottom, 50)
                        .alert("Fill your health data", isPresented: $calculationViewModel.showAlert) {
                            
                        } message: {
                            Text("Please fill your health data in settings. Health data is for determine your ideal calorie intake based on your BMI.")
                        }

                }.padding(.horizontal,15)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
            }
            .onChange(of: calculationViewModel.allFilled) { newValue in
                if newValue == true {
                    showHome = true
                }
            }
            .onAppear {
                print("†est")
            }
            
        }
    }
}


