//
//  EmptyListView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 26/07/23.
//

import SwiftUI

struct EmptyListView: View {
    var background: Bool = true
    var body: some View {
        VStack {
            Image("empty_bowl")
            Text("Nothing to see here,").font(.body)
            Text("You haven’t input your meal.").font(.body)
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 18, trailing: 20))
        .frame(width: UIScreen.main.bounds.width-40)
        .background(background ? Color("bg_blue") : Color.clear)
        .cornerRadius(29)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
