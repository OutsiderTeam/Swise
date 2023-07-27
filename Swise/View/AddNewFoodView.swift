//
//  AddNewFood.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 21/07/23.
//

import SwiftUI

struct AddNewFoodView: View {
    @State private var foodName: String = ""
    @State private var sugarAdded: String = ""
    @State private var calories: String = ""
    @State private var servingName: String = ""
    @State var isPresented: Bool = false
    let servingOption = ["1 Cup","1 spoon","1 teaspoon"]
    var body: some View {
        NavigationView {
            VStack{
                // Form for details of the new food
                Form {
                    Section{
                        HStack{
                            Text("Food Name")
                            TextField("Value",text: $foodName).padding(.leading,112)
                        }.listRowBackground(Color("bg_blue").padding(.bottom,3))
                        Group {
                            HStack{
                                Text("Sugar Added (g)")
                                TextField("Value",text: $sugarAdded).padding(.leading,74)
                            }
                            
                            HStack{
                                Text("Amount Calories (kcal)").padding(.trailing,-21)
                                TextField("Value",text: $calories).padding(.leading,48)
                            }
                        }.listRowBackground(Color("bg_blue").padding(.vertical,3))
                        HStack{
                            Picker(selection: $servingName, label: Text("Serving Size")) {
                                ForEach(servingOption, id: \.self) { option in
                                    Text((option))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                        }.listRowBackground(Color("bg_blue").padding(.top,3))
                    }
                    .listRowSeparator(.hidden)
                    
                }.scrollContentBackground(.hidden)
                
                // Button for take an action to add new food
                Button(
                    action: {
                        isPresented=true
                    }){
                        HStack{
                            Text("Add food")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }.foregroundColor(.white).frame(width: 261, height: 48).background(Color("button_color")).cornerRadius(11)
                        
                    }.padding()
            }
            
            
            
        }
        .navigationTitle("Add New Food")
        
    }
}

struct AddNewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFoodView()
    }
}
