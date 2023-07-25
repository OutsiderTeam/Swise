//
//  FoodInformationView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import SwiftUI

struct FoodInformationView: View {
    @State private var foodName: String = "Plain Cheeseburger"
    @State private var sugarAdded: String = "12 gr"
    @State private var calories: String = "202 kcal"
    @State private var servingName: String = "1 Portion"
    var body: some View {
        NavigationView {
            VStack{
                // Form for details of the new food
                Form {
                    Section{
                        Text("\(foodName)").font(.title2).bold()
                        HStack{
                            Text("Servings")
                            Text(": \(servingName) ").bold().padding(.leading,108)
                        }
                        HStack{
                            Text("Added Sugar")
                            Text(": \(sugarAdded) ").bold().padding(.leading,75)
                        }
                        
                        HStack{
                            Text("Amount Calories")
                            Text(": \(calories)").bold().padding(.leading,48)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    
                }.padding(-20)
                .background(Color("bg_blue"))
                    .frame(width: 350, height: 202)
                    .cornerRadius(29)
                .scrollContentBackground(.hidden)
                Spacer()
                
                // Button for take an action to add new food
                Button(
                    action: {
                        
                    }){
                        HStack{
                            Text("Done")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }.foregroundColor(.white).frame(width: 261, height: 48).background(Color("button_color")).cornerRadius(11)
                        
                    }.padding()
            }
            
        }
        .navigationTitle("New Food")
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView()
    }
}
