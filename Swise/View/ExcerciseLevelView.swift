//
//  ExerciseLevelView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct ExcerciseLevelView: View {
    @State private var activityIntensity: Activity = .no
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    @State private var selectedActivity = 0
    @State var isPresented: Bool = false
    
    @AppStorage("lastScreen") var lastScreen: String = ""
    
    
    let persistenceController = PersistenceController.shared
    
    @State var activityIntens = [
        ActivityDetail(activity: .no, description: "Individuals who have a very inactive lifestyle and engage in little to no structured exercise."),
        ActivityDetail(activity: .light, description: "This category engage in light exercise or physical activity 1 to 3 days a week."),
        ActivityDetail(activity: .moderate, description: "Individuals with a moderate activity level participate in exercise or physical activities 3 to 5 days a week."),
        ActivityDetail(activity: .very, description: "Who engage in intense exercise or physical activities 6 to 7 days a week."),
        ActivityDetail(activity: .extra, description: "individuals with a physically demanding job combined with intense exercise.")
    ]
    var body: some View {
        VStack{
            Text("What is your excercise level").bold()
            ForEach(0..<activityIntens.count, id: \.self ) { index in
                Button {
                    
                } label: {
                    VStack(alignment: .leading){
                        Text("\(activityIntens[index].activity.rawValue)").bold()
                        Text("\(activityIntens[index].description)").font(.caption)
                    }.padding()
                        .frame(width: 333, alignment: .topLeading)
                        .foregroundColor(.black)
                    .background(Color("bg_yellow"))
                    .cornerRadius(11)
                    .onTapGesture {
                        selectedActivity = index
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 11)
                        .stroke(Color("button_color"), lineWidth: selectedActivity==index ? 2: 0)
                )
            }
            Text("\(calculationViewModel.activityIntensity.rawValue)")
            Button {
                calculationViewModel.activityIntensity = activityIntens[selectedActivity].activity
                lastScreen = "Main Screen"
                isPresented = true
            } label: {
                Image(systemName: "arrow.right")
                    .font(.largeTitle).foregroundColor(.white)
                    .frame(width: 193, height: 71)
                    .background(Color("button_color"))
                    .cornerRadius(11)
                    .padding(.top,60)
            }.padding(.bottom, 50)
            
        }.padding(.horizontal,15)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .navigationDestination(isPresented: $isPresented) {
                TabNavView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }

    }
}

struct ExcerciseLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseLevelView()
    }
}
