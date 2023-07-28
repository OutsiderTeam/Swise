//
//  ProfileView.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 28/07/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var calculationViewModel: DataCalculationViewModel
    var body: some View {
        NavigationView {
            CustomNavBarContainerView(isSearch: false) {
                VStack{
                    Image("smily_sugar").padding()
                    VStack(alignment: .leading){
                        HStack{
                            Text("Age")
                            Text(": \(calculationViewModel.age, specifier: "%.f")").padding(.leading,90).bold()
                        }.padding(.top,3)
                            .padding(.horizontal, 50)
                        HStack{
                            Text("Height")
                            Text(": \(calculationViewModel.height, specifier: "%.f") cm").padding(.leading,70).bold()
                        }.padding(.top,3)
                            .padding(.horizontal, 50)
                        HStack{
                            Text("Weight")
                            Text(": \(calculationViewModel.weight, specifier: "%.f") kg").padding(.leading,66).bold()
                        }.padding(.top,3)
                            .padding(.horizontal, 50)
                        HStack{
                            Text("Sex")
                            Text(": \(calculationViewModel.sex.rawValue)").padding(.leading,90).bold()
                        }.padding(.top,3)
                            .padding(.horizontal, 50)
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .background(Color("bg_yellow"))
                        .cornerRadius(29)
                    Spacer()
                }.padding()
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .onAppear{
            calculationViewModel.healthRequest()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
