//
//  EmptyListView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 26/07/23.
//

import SwiftUI

struct EmptyListView: View {
    var background: Bool = true
    var titleMessage: String = "Nothing to see here,"
    var bodyMessage: String = "You haven’t input your meal."
    var image: String = "empty_bowl"
    var body: some View {
        VStack {
            Image(image)
            Text(titleMessage).font(.body)
            if bodyMessage != "" {
                Text(bodyMessage ).font(.body)
            }
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
