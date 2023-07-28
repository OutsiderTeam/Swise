//
//  CustomNavBarView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 27/07/23.
//

import SwiftUI

struct CustomSearchView: View {
    
    
    @Binding var text: String
    @State private var isEditing = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack{
            TextField("Search....", text: $text)
                .focused($isFocused)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal,18)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing{
                Button {
                    self.isEditing = false
                    isFocused = false
                    self.text = ""
                } label: {
                    Text("Cancel")
                }.padding(.trailing, 10)

            }
            
        }
    }
}

