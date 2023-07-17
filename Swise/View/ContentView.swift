//
//  ContentView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = FoodViewModel(foodService: FoodStore.shared)

    @State private var search: String = ""
    @State var isPresented: Bool = false

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>

    var body: some View {
        NavigationStack {
            VStack {
                if search == "" {
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
                        .onDelete(perform: deleteItems)
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
                            DetailFoodView(totalSugar: items.isEmpty ? 0 : items[0].totalSugar, totalCalories: items.isEmpty ? 0 : items[0].totalCalories )
                        }
                    }
                }
            }

            Text("Select an item")
        }
        .environmentObject(viewModel)
        .searchable(text: $search)
        .onSubmit(of: .search) {
            viewModel.searchFood(query: search)
        }

    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
