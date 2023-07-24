//
//  HistoryView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 20/07/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var weekStore = WeekStore()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var selectedDate: [DataItem] = []
    @State var eatenFoods: [EatenFoods] = []
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    DatePicker(
                        "", selection: $weekStore.currentDate,
                        displayedComponents: [.date]
                    )
                    
                    .labelsHidden()
                    .padding(.top, 20)
                    
                    ZStack {
                        ForEach(weekStore.allWeeks) { week in
                            VStack{
                                HStack(spacing: 10) {
                                    ForEach(0..<7) { index in
                                        VStack(spacing: 15) {
                                            Text(weekStore.dateToString(date: week.date[index], format: "EEEEE"))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .frame(maxWidth:.infinity)
                                            
                                            Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                                .font(.subheadline)
                                                .frame(maxWidth:.infinity)
                                            Text("😡")
                                                .font(.title2)
                                                .padding(5)
                                                .frame(width: 40, height: 30)
                                                .background(Color.white)
                                                .cornerRadius(12)
                                        }
                                        .frame(width: 43, height: 100)
                                        .background(Calendar.current.isDate(week.date[index], inSameDayAs: weekStore.currentDate) ? Color("button_color") : Color("bg_blue"))
                                        .foregroundColor(Calendar.current.isDate(week.date[index], inSameDayAs: weekStore.currentDate) ? Color.white : Color.black)
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            // Updating Current Day
                                            weekStore.currentDate = week.date[index]
                                        }
                                    }
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width)
                                .background(
                                    Rectangle()
                                        .fill(.white)
                                )
                            }
                            .offset(x: myXOffset(week.id), y: 0)
                            .zIndex(1.0 - abs(distance(week.id)) * 0.1)
                        }
                    }
                    .frame(alignment : .top)
                    .padding(.top, 20)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                draggingItem = snappedItem + value.translation.width / 400
                            }
                            .onEnded { value in
                                withAnimation {
                                    if value.predictedEndTranslation.width > 0 {
                                        draggingItem = snappedItem + 1
                                    } else {
                                        draggingItem = snappedItem - 1
                                    }
                                    snappedItem = draggingItem
                                    
                                    weekStore.update(index: Int(snappedItem))
                                }
                            }
                    )
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total added sugar")
                            Text("Total calories")
                        }
                        VStack {
                            Text(":")
                            Text(":")
                        }
                        VStack(alignment: .leading) {
                            Text("\(String(selectedDate.first?.totalSugar ?? 0)) gr")
                            Text("\(String(selectedDate.first?.totalCalories ?? 0)) Kcal")
                        }
                        Spacer()
                        
                    }
                    .padding(20)
                    if !eatenFoods.isEmpty {
                        VStack(spacing: 6) {
                            ForEach(eatenFoods, id:\.self) { food in
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top, spacing: 10) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(food.wrappedFoodName).font(.headline)
                                                Text(food.servingFood?.servingDescription ?? "")
                                            }
                                            Spacer()
                                        }.frame(width: UIScreen.main.bounds.width*0.4)
                                        Text("\(food.servingFood?.calories ?? "0") Kcal")
                                            .font(.headline)
                                            .frame(alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: UIScreen.main.bounds.width*0.2)
                                        Text("\(food.servingFood?.sugar ?? "0") gr")
                                            .font(.headline)
                                            .frame(width: UIScreen.main.bounds.width*0.2)

                                    }
                                }
                                .padding(15)
                                .frame(width: UIScreen.main.bounds.width-40)
                                .background(Color("bg_blue"))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.top, 50)

                    }
                    
                }
            }

            .onAppear {
                selectedDate = items.filter {$0.date == weekStore.currentDate.formatted(date: .complete, time: .omitted)}
                eatenFoods = selectedDate.first?.eatenFoodsArray ?? []
            }
            .onChange(of: weekStore.currentDate) { newValue in
                selectedDate = items.filter {$0.date == newValue.formatted(date: .complete, time: .omitted)}
                eatenFoods = selectedDate.first?.eatenFoodsArray ?? []
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white)
            .navigationTitle("Food History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(weekStore.allWeeks.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(weekStore.allWeeks.count) * distance(item)
        return sin(angle) * 200
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
