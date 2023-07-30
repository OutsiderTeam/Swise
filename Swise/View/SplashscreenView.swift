//
//  SplashscreenView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 31/07/23.
//

import SwiftUI

struct SplashscreenView: View {
    @AppStorage("lastScreen") var lastScreen: String = ""
    @State var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .background(Color("blue_color"))
                    .foregroundColor(Color("blue_color"))
                Image("splashscreen")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
            }
            .navigationDestination(isPresented: $isPresented) {
                if lastScreen == "" {
                    OnBoardingView()
                } else {
                    TabNavView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    isPresented = true
                }
        }
        }
    }
}

struct SplashscreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashscreenView()
    }
}
