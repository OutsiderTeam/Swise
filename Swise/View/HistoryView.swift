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
        sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)],
        animation: .default)
    private var items: FetchedResults<DataItem>
    var isFoodDiary = false
    
    var body: some View {
        NavigationStack {
            CustomNavBarContainerView(isSearch: false) {
                VStack(spacing: 0) {
                    if !isFoodDiary {
                        VStack {
                            DatePicker(
                                "", selection: $weekStore.currentDate,
                                displayedComponents: [.date]
                            )
                            .labelsHidden()
                            .padding(.top, 20)
                            
                            ZStack {
                                ForEach(weekStore.allWeeks, id: \.id) { week in
                                    VStack{
                                        HStack(spacing: 7) {
                                            ForEach(0..<7) { index in
                                                VStack(spacing: 7) {
                                                    Text(weekStore.dateToString(date: week.date[index], format: "EEEEE"))
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                        .frame(maxWidth:.infinity)
                                                }
                                                .frame(width: 40, height: 40)
                                                .background(week.sugarCondition[index] == 0 ? Color("bg_green") : week.sugarCondition[index] == 1 ? Color("bg_orange") : week.sugarCondition[index] == 2 ? Color("bg_red") :  Color("bg_blue"))
                                                .overlay(
                                                    VStack {
                                                        if Calendar.current.isDate(week.date[index], inSameDayAs: weekStore.currentDate) {
                                                            Circle()
                                                                .stroke(Color(red: 0.23, green: 0.82, blue: 0.82), lineWidth: 5)
                                                        } else {
                                                            EmptyView()
                                                        }
                                                    }
                                                )
                                                .foregroundColor(Color.black)
                                                .cornerRadius(20)
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
                                            
                                            weekStore.update(index: Int(snappedItem), items: items.sorted {$0.timestamp ?? Date() < $1.timestamp ?? Date()})
                                        }
                                    }
                            )
                            
                        }
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Amount added sugar").font(.body)
                            Text("Amount calories").font(.body)
                        }
                        VStack {
                            Text(":").font(.body)
                            Text(":").font(.body)
                        }
                        VStack(alignment: .leading) {
                            Text("\(selectedDate.first?.totalSugar ?? 0, specifier: "%.f") gr").font(.headline)
                            Text("\(selectedDate.first?.totalCalories ?? 0, specifier: "%.f") Kcal").font(.headline)
                        }
                        Spacer()
                        
                    }
                    .padding(20)
                    ScrollView {
                        
                        if !eatenFoods.isEmpty {
                            VStack(spacing: 6) {
                                ForEach(eatenFoods, id:\.self) { food in
                                    FoodItemView(name: food.wrappedFoodName, calories: food.servingFood?.calories ?? "0", sugar: food.servingFood?.sugar ?? "0", serving: food.servingFood?.servingDescription ?? "")
                                }
                            }
                            .padding(.top, 30)
                        } else {
                            VStack {
                                EmptyListView(background: false)
                            }.frame(height: UIScreen.main.bounds.height / 2, alignment: .center)
                        }
                    }
                }
                
                .onAppear {
                    selectedDate = items.filter {$0.date == weekStore.currentDate.formatted(date: .complete, time: .omitted)}
                    eatenFoods = selectedDate.first?.eatenFoodsArray ?? []
                    if !isFoodDiary {
                        weekStore.fetchAll(items: items.sorted {$0.timestamp ?? Date() < $1.timestamp ?? Date()})
                    }
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
