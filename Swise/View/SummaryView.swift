//
//  SummaryView.swift
//  Swise
//
//  Created by Mutiara Ruci on 17/07/23.
//

import SwiftUI

struct SummaryView: View {
    @State var progressValue: Float = 0.65
    var body: some View {
        ZStack{
            ScrollView{
                ZStack{
                    VStack{
                        HStack{
                            Text("Today").bold().font(.system(size:34)).padding(.trailing, 200)
                            Image(systemName: "info.circle").resizable().frame(width: 25, height: 25).background(Color.white).clipShape(Circle())
                        }
                        HStack{
                            VStack{
                                Text("You've Consumed")
                                HStack{
                                    Text("5 gr").bold().font(.system(size: 25))
                                    Text("/50 gr").font(.system(size: 19)).padding(.top, 9)
                                    Text("of sugar today!").padding(.top, 9)
                                }
                                Image("spoon")
                                Text("or equals 1 teaspoon!")
                                
                            }.padding()
                        }
                        
                    }
                }
                
                VStack{
                    Text("Calorie Count").font(.system(size: 22)).padding(.trailing,210)
                }
                ZStack{
                    HStack{
                        ProgressBar(progress: self.$progressValue)
                            .frame(width: 80.0, height: 80.0)
                            .padding(40.0)
                        VStack(alignment: .leading){
                            HStack{
                                Text("56 kcal").foregroundColor(.black).bold().font(.system(size: 20))
                                Text("/2200 kcal").font(.system(size: 14))
                            }
                            
                            Text("*Based on your BMI, your max. calorie intake is 2200 kcal").foregroundColor(.black).font(.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 5)
                        }.padding(.trailing, 15)
                        
                    }
                }.frame(width: 359, height: 124).background(Color("bg_blue")).cornerRadius(29)
                
                VStack{
                    Text("Food Diary").font(.system(size: 22)).padding(.trailing,230)
                }
                ZStack{
                    HStack{
                        VStack{
                            Text("🫐🧀").padding(.top, 10).foregroundColor(.black).bold().font(.system(size: 20))
                            
                            Text("What have you eaten today? Let us track here!").foregroundColor(.black).font(.system(size: 18)).multilineTextAlignment(.center).padding(.top, 1)
                            Button(
                                action: {
                                    
                                }){
                                    Text("Add your food")
                                        .foregroundColor(.black).frame(width: 288, height: 46).background(Color("button_color")).cornerRadius(11)
                                }.padding()
                            
                        }.padding(.trailing, 15)
                        
                    }
                    
                    
                }.frame(width: 359, height: 186).background(Color("bg_yellow")).cornerRadius(29)
                ZStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text("Bubur Ayam").padding(.trailing, 55)
                            Text("17 kcal").padding(.trailing, 55)
                            Text("2 gr")
                        }.padding(.vertical, 0.4).bold().font(.system(size:17))
                        
                        Text("1 bowl")
                    }
                }.frame(width: 356, height: 69.63).background(Color("bg_yellow")).cornerRadius(15)
                ZStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text("Bubur Ayam").padding(.trailing, 55)
                            Text("17 kcal").padding(.trailing, 55)
                            Text("2 gr")
                        }.padding(.vertical, 0.4).bold().font(.system(size:17))
                        
                        Text("1 bowl")
                    }
                }.frame(width: 356, height: 69.63).background(Color("bg_yellow")).cornerRadius(15)
                
                VStack{
                    Text("For You").font(.system(size: 22)).padding(.trailing,260)
                }
                HStack{
                    ZStack{
                        VStack(alignment: .leading){
                            Text("What is BMI?").bold().padding(.bottom, 9)
                            Text("Do you know BMI is a measure if your weight is healthy or not.")
                        }.padding()
                    }.frame(width: 169, height: 186).background(Color("bg_pink")).cornerRadius(29)
                    ZStack{
                        VStack(alignment: .leading){
                            Text("What is BMI?").bold().padding(.bottom, 9)
                            Text("Do you know BMI is a measure if your weight is healthy or not.")
                        }.padding()
                    }.frame(width: 169, height: 186).background(Color("bg_blue")).cornerRadius(29)
                }
               
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white).foregroundColor(.black)
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("button_color"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.title3)
                .bold()
        }
    }
}

extension View {
    func getscreenBound() -> CGRect{
        return UIScreen.main.bounds
    }
}
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
