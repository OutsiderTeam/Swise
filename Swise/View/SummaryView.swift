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
        NavigationView{
            ZStack{
                ScrollView{
                    ZStack{
                        VStack{
                            HStack{
                                Text("Today").bold().font(.title).padding(.trailing, 200)
                                Image(systemName: "info.circle").resizable().frame(width: 25, height: 25).background(Color.white).clipShape(Circle())
                            }
                            HStack{
                                VStack{
                                    Text("You've Consumed").font(.title2)
                                    HStack{
                                        Text("5 gr").bold().font(.title2)
                                        Text("/50 gr").font(.title2).padding(.top, 9)
                                        Text("of sugar today!").font(.title2).padding(.top, 9)
                                    }
                                    Image("spoon")
                                    Text("or equals 1 teaspoon!").font(.title2)
                                    
                                }.padding()
                            }
                            
                        }
                    }
                    ZStack{
                        VStack{
                            Text("Calorie Count").font(.title2).padding(.trailing,210).padding(.top)
                            ZStack{
                                HStack{
                                    ProgressBar(progress: $progressValue)
                                        .frame(width: 80.0, height: 80.0)
                                        .padding(30.0)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text("56 kcal/").fontWeight(.bold).foregroundColor(.black).bold().font(.title2)
                                            Text("2200 kcal").font(.body)
                                        }
                                        
                                        Text("*Based on your BMI, your max. calorie intake is 2200 kcal").foregroundColor(.black).font(.footnote).multilineTextAlignment(.leading).padding(.top, 5)
                                    }.padding(.trailing, 15)
                                    
                                }
                            }.frame(width: 359, height: 124).background(Color("bg_blue")).cornerRadius(29)
                            
                            VStack{
                                Text("Food Diary").font(.title2).padding(.trailing,230)
                            }
                            ZStack{
                                HStack{
                                    VStack{
                                        Text("🫐🧀").padding(.top, 10).foregroundColor(.black).bold().font(.system(size: 20))
                                        
                                        Text("What have you eaten today? Let us track here!").fontWeight(.semibold).foregroundColor(.black).font(.headline).multilineTextAlignment(.center).padding(.top, 1)
                                       NavigationLink(destination: AddFoodView(text: .constant(""))){
                                           Text("Add your food").font(.headline)
                                               .fontWeight(.semibold)
                                               .foregroundColor(.white).frame(width: 288, height: 46).background(Color("button_color")).cornerRadius(11)
                                            }
                                    }.padding()
                                    
                                }
                                
                                
                            }.frame(width: 359, height: 186).background(Color("bg_yellow")).cornerRadius(29).padding(.bottom, 9)
                            ZStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Bubur Ayam").font(.headline).fontWeight(.semibold).padding(.trailing, 55)
                                        Text("17 kcal").font(.headline).fontWeight(.semibold).padding(.trailing, 55)
                                        Text("2 gr")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }.padding(.vertical, 0.4).bold()
                                    
                                    Text("1 bowl")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                }
                            }.frame(width: 356, height: 69.63).background(Color("bg_yellow")).cornerRadius(15).padding(.bottom, 9)
                            ZStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Bubur Ayam").font(.headline).fontWeight(.semibold).padding(.trailing, 55)
                                        Text("17 kcal").font(.headline).fontWeight(.semibold).padding(.trailing, 55)
                                        Text("2 gr")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }.padding(.vertical, 0.4).bold()
                                    
                                    Text("1 bowl")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                }
                            }.frame(width: 356, height: 69.63).background(Color("bg_yellow")).cornerRadius(15).padding(.bottom, 9)
                            Text("Show More").font(.headline).fontWeight(.semibold).padding(.leading, 250).padding(.bottom, 25)
                            
                            Text("For You").font(.title2).padding(.trailing,260)
                        
                            HStack{
                                ZStack{
                                    VStack(alignment: .leading){
                                        Text("What is BMI?").font(.headline).fontWeight(.semibold).padding(.bottom, 9)
                                        Text("Do you know BMI is a measure if your weight is healthy or not.")
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }.padding()
                                }.frame(width: 169, height: 186).background(Color("bg_pink")).cornerRadius(29)
                                ZStack{
                                    VStack(alignment: .leading){
                                        Text("What is BMI?").font(.headline).fontWeight(.semibold).padding(.bottom, 9)
                                        Text("Do you know BMI is a measure if your weight is healthy or not.")
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }.padding()
                                }.frame(width: 169, height: 186).background(Color("bg_blue")).cornerRadius(29)
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("bg_white"))
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white).foregroundColor(.black)
            }
        }.navigationBarTitle("Summary")
        
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
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("button_color"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(String(format: "%.0f %%", min(progress, 1.0)*100.0))
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
