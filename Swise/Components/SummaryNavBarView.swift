//
//  SummaryNavBarView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 29/07/23.
//

import SwiftUI

struct SummaryNavBarView: View {
    @Binding var smallHeader: Bool
    @Binding var isPresented: Bool
    var namespace: Namespace.ID
    var body: some View {
        VStack {
            if !smallHeader {
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 280)
                        .foregroundColor(Color("bg_blue"))
                        .background(Color("bg_blue"))
                        .cornerRadius(29, corners: [.bottomLeft, .bottomRight])
                        .matchedGeometryEffect(id: "background", in: namespace)

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Hi, Swiser!")
                                .font(.largeTitle)
                                .frame(width: UIScreen.main.bounds.width/2, alignment: .leading)
                                .matchedGeometryEffect(id: "title", in: namespace)
                            Spacer()
                        }.padding(.top, 20)
                        HStack(alignment: .top){
                            VStack(alignment: .leading){
                                HStack(alignment: .center, spacing: 30) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("What have you eaten today?").font(.headline).fontWeight(.semibold)
                                        Text("Add your meal now!").font(.headline).fontWeight(.semibold)
                                    }
                                    Image("bowl")
                                        .resizable()
                                        .frame(width: 77, height: 84)
                                }
                                Button {
                                    isPresented = true
                                } label: {
                                    VStack {
                                        Text("Add your meal").foregroundColor(.white)
                                    }
                                    .padding(.vertical, 12)
                                    .frame(width: UIScreen.main.bounds.width-40)
                                    .background(Color("button_color"))
                                    .cornerRadius(11)
                                }.shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
                }
            } else {
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                        .foregroundColor(Color("bg_blue"))
                        .background(Color("bg_blue"))
                        .cornerRadius(29, corners: [.bottomLeft, .bottomRight])
                        .matchedGeometryEffect(id: "background", in: namespace)
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center) {
                            Text("Hi, Swiser!")
                                .font(.body)
                                .bold()
                                .frame(width: UIScreen.main.bounds.width/2)
                                .matchedGeometryEffect(id: "title", in: namespace)
                        }.padding(.top, 40)
                    }
                }
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.top)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct SummaryNavBarView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SummaryNavBarView(smallHeader: .constant(false), isPresented: .constant(false), namespace: namespace)
    }
}
