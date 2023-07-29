//
//  NoFilledHealthView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 29/07/23.
//

import SwiftUI

struct NoFilledHealthView: View {
    @State private var showAlert = false
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("lastScreen") var lastScreen: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center){
                    Text("Fill out your health data")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top, 50)
                    VStack{
                        Text("To get started, kindly fill in your basic health information, including your date of birth, sex, weight, and height within the Health app. This will enable you to proceed to the next step and make the most of our app's features.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding()
                            
                    }.background(Color("bg_yellow")).cornerRadius(15)
                        .padding()
                    Image("smily_sugar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 186)
                        .padding(.top, 50)
                    
                    Button {
                        calculationViewModel.healthRequest()
                        if !calculationViewModel.allFilled{
                            showAlert = true
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.largeTitle).foregroundColor(.white)
                            .frame(width: 193, height: 71)
                            .background(Color("button_color"))
                            .cornerRadius(11)
                            .padding(.top, 100)
                    }.padding(.bottom, 50)
                        .alert("Fill your health data", isPresented: $showAlert) {
                            
                        } message: {
//                            Text("Please Filled Your")
                            if calculationViewModel.height == 0{
                                Text("Please filled your Height")
                            }
                            if calculationViewModel.age == 0{
                                Text("Please filled your Age")
                            }
                            if calculationViewModel.sex == .notRetrived{
                                Text("Please filled your Sex")
                            }
                            if calculationViewModel.sex == .other{
                                Text("Please filled your sex with Male or Female, so we can calculate your calorie and Sugar Intake")
                            }
                        }
                    
                }.padding(.horizontal, 15)
            .onChange(of: calculationViewModel.allFilled) { newValue in
                if newValue == true {
                    lastScreen = "Excercise"
                }else {
                    lastScreen = "Health Checker"
                }
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .inactive || newScenePhase == .active {
                    calculationViewModel.healthRequest()
                }
            }
            
        }
    }
}





