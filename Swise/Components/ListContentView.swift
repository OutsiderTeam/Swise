//
//  ListContentView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 17/07/23.
//

import SwiftUI

struct ListContentView: View {
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject var viewModel: FoodViewModel
    @Binding var isPresented: Bool
    @Binding var search: String
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DataItem.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<DataItem>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryFoods.foodName, ascending: true)],
        animation: .default)
    private var historyFoods: FetchedResults<HistoryFoods>
    
    var body: some View {
        VStack {
            if isSearching && search == "" {
                Text("isSearch")
                List {
                    ForEach(historyFoods) { item in
                        
                        VStack {
                            VStack {
                                Text(item.foodName ?? "")
                                Text(item.foodType ?? "")
                            }
                            
                        }
                    }
                }
            } else if search == "" {
                List {
                    ForEach(items) { item in
                        
                        VStack {
                            HStack {
                                Text("TotalSugar")
                                Spacer()
                                Text(item.totalSugar.description)
                            }
                            HStack {
                                Text("TotalCalories")
                                Spacer()
                                Text(item.totalCalories.description)
                            }
                            Section(item.wrappedDate) {
                                ForEach(item.eatenFoodsArray, id:\.self) { food in
                                    VStack {
                                        Text(food.wrappedFoodName)
                                        Text(food.wrappedFoodType)
                                        Text(food.servingFood?.servingDescription ?? "")
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            } else {
                if !viewModel.resultSearch.isEmpty {
                    List {
                        ForEach(viewModel.resultSearch, id: \.foodId) { food in
                            Text(food.foodName).onTapGesture {
                                viewModel.getFood(id: Int(food.foodId)!)
                                isPresented = true
                            }
                        }
                    }
                    .navigationDestination(isPresented: $isPresented) {
                        DetailFoodView(totalSugar: items.isEmpty || items[0].date != Date().formatted(date: .complete, time: .omitted) ? 0 : items[0].totalSugar, totalCalories: items.isEmpty || items[0].date != Date().formatted(date: .complete, time: .omitted)  ? 0 : items[0].totalCalories )
                    }
                }
            }
        }
    }
}

struct ListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListContentView(isPresented: .constant(false), search: .constant("")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
