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
                VStack {
                    Text(fyiData.title).font(.headline)
                    VStack(alignment: .leading) {
                        ForEach(fyiData.desc, id: \.self) { desc in
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
                    }.padding(EdgeInsets(top: 30, leading: 20, bottom: 50, trailing: 20))
                }
//                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("bg_yellow"))
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(fyiData: .constant(FYIModel(title: "title", shortDesc: "shortdesc", image: "", desc: [])))
    }
}
