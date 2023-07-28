//
//  FoodItemView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 25/07/23.
//

import SwiftUI

struct FoodItemView: View {
    var name: String
    var calories: String
    var sugar: String
    var serving: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(name).font(.headline)
                Spacer()
            }
            HStack(alignment: .top) {
                HStack {
                    Text(serving).font(.callout)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width*0.4)
                Text("\(calories) Kcal")
                    .font(.body)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.main.bounds.width*0.2)
                Text("\(sugar) gr")
                    .font(.body)
                    .frame(width: UIScreen.main.bounds.width*0.2)

            }
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width-40)
        .background(Color("bg_yellow"))
        .cornerRadius(12)    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(name: "", calories: "", sugar: "", serving: "")
    }
}
