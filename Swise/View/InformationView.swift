//
//  InformationView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 27/07/23.
//

import SwiftUI

struct InformationView: View {
    @Binding var fyiData: FYIModel
    var body: some View {
        VStack {
            ScrollView {
                Image(fyiData.image).padding(.bottom, 20)
                VStack {
                    Text(fyiData.title).font(.headline).multilineTextAlignment(.center).padding(.top, 12)
                    VStack(alignment: .leading) {
                        ForEach(fyiData.desc, id: \.id) { desc in
                            VStack(alignment: .leading, spacing: 0) {
                                if desc.styling == "none" {
                                    Text(desc.content).font(.body)
                                } else if desc.styling == "bullet" {
                                    HStack(alignment: .top) {
                                        Text("•").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "1" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("1. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "2" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("2. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "3" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("3. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "4" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("4. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "5" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("5. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "6" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("6. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "7" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("7. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "8" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("8. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "9" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("9. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                } else if desc.styling == "10" {
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("10. ").font(.body)
                                        Text(desc.content).font(.body)
                                    }
                                }
                            }
                        }
                    }.padding(EdgeInsets(top: 30, leading: 12, bottom: 50, trailing: 12))
                }
//                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("bg_yellow"))
                .cornerRadius(12)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(fyiData: .constant(FYIModel(title: "title", shortDesc: "shortdesc", image: "", desc: [])))
    }
}
