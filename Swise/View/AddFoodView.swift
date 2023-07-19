//
//  AddFoodView.swift
//  Swise
//
//  Created by Mutiara Ruci on 19/07/23.
//

import SwiftUI

struct AddFoodView: View {
    @Binding var text: String
    
       @State private var isEditing = false
    
       var body: some View {
           VStack{
               Text("Add Food")
                   .fontWeight(.bold)
                   .font(.title).padding(.trailing, 240)
               HStack{
                   TextField("Search ...", text: $text)
                       .padding(7)
                       .padding(.horizontal, 25)
                       .background(Color(.systemGray6))
                       .cornerRadius(8).overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                       .padding(.horizontal, 10)
                       .onTapGesture {
                           self.isEditing = true
                       }
        
                   if isEditing {
                       Button(action: {
                           self.isEditing = false
                           self.text = ""
        
                       }) {
                           Text("Cancel")
                       }
                       .padding(.trailing, 10)
                       .transition(.move(edge: .trailing))
                       .animation(.default)
                   }
               }
               
               Divider().background(Color.gray.opacity(0.7))
               
               Button(
                   action: {
                       
                   }){
                       HStack{
                           Image(systemName: "plus.circle")
                           Text("Add your food manually")
                               .font(.headline)
                               .fontWeight(.semibold)
                       }.foregroundColor(.white).frame(width: 358, height: 50).background(Color("button_color")).cornerRadius(11)
                       
                           
                   }.padding()
               
           }.padding(.bottom, 490)
         
       }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(text: .constant(""))
    }
}
