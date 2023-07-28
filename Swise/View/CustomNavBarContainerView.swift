//
//  CustomNavBarContainerView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 27/07/23.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    let isSearch: Bool
    
    init(isSearch: Bool, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.isSearch = isSearch
    }
    @State var text: String = ""
    var body: some View {
        VStack(spacing: 0) {
            if isSearch{
                Rectangle()
                    .cornerRadius(29, corners: [.bottomLeft, .bottomRight])
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .foregroundColor(Color("bg_blue"))
            }else{
                Rectangle()
                    .cornerRadius(29, corners: [.bottomLeft, .bottomRight])
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .foregroundColor(Color("bg_blue"))
            }
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.ignoresSafeArea(edges: .top)
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView(isSearch: false) {
            Color.red.edgesIgnoringSafeArea(.top)
        }
    }
}
