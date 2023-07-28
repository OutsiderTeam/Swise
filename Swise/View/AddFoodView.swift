//
//  AddFoodView.swift
//  Swise
//
//  Created by Mutiara Ruci on 19/07/23.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var viewModel: FoodViewModel
    @Binding var maxSugar: Int
    @State var text: String = ""
    @State var foodManual: Bool = false
    @State var isDetailed: Bool = false
    @State var isPresented: Bool = false
    @State private var isEditing = false
    @State private var statusBar = UIStatusBarStyle.lightContent
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>
    var calNeed: Double = 0
    @State var data: [EatenFoods] = []
    
    var body: some View {
        NavigationView {
            
            VStack{
                ZStack{
                    CustomNavBarContainerView(isSearch: true){
                        if text == "" {
                            VStack(alignment: .leading){
                                Text("Your recent search").font(.headline).padding()
                                    if data.count > 0 {
                                        List{
                                            ForEach(0..<(data.count <= 5 ? data.count : 5), id: \.self) { i in
                                                
                                                HStack{
                                                    Text("\(data[i].foodName!)")
                                                    Spacer()
                                                    Image(systemName: "chevron.right")
                                                }
                                                .padding()
                                                .listRowBackground(Color("bg_yellow").cornerRadius(10).padding(3))
                                            }.listRowSeparator(.hidden)
                                        }.scrollContentBackground(.hidden)
                                            .frame(maxHeight: .infinity)
                                    } else {
                                        EmptyListView()
                                    }
                            }
                            
                            
                            Button(
                                action: {
                                    foodManual = true
                                }){
                                    HStack{
                                        Image(systemName: "plus.circle")
                                        Text("Add your food manually")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }.foregroundColor(.white).frame(width: 358, height: 50).background(Color("button_color")).cornerRadius(11)
                                    
                                }
                        } else {
                            ZStack{
                                Color.white
                                if !viewModel.resultSearch.isEmpty {
                                    List {
                                        ForEach(viewModel.resultSearch, id: \.foodId) { food in
                                            HStack{
                                                Text(food.foodName).onTapGesture {
                                                    viewModel.getFood(id: Int(food.foodId)!)
                                                    isPresented = true
                                                }
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                            .padding()
                                            .frame(width: 361, height: 47)
                                            .listRowBackground(Color("bg_yellow").cornerRadius(10).padding(3))
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                    
                                    
                                    .scrollContentBackground(.hidden)
                                    .navigationDestination(isPresented: $isPresented) {
                                        FoodInformationView(maxSugar: $maxSugar, totalSugar: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalSugar ?? 0, totalCalories: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalCalories ?? 0, calNeed: calNeed)
                                    }
                                }
                            }
                        }
                        
                    }
                    VStack{
                        CustomSearchView(text: $text).position(x:190, y: 30)
                    }
                }
                
                
            }
        }
            .navigationTitle("Add Food")
            
            .navigationDestination(isPresented: $foodManual, destination: {
                AddNewFoodView(maxSugar: $maxSugar, totalSugar: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalSugar ?? 0, totalCalories: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalCalories ?? 0, calNeed: calNeed)
            })
            .onChange(of: text, perform: { newValue in
                
                viewModel.searchFood(query: text)
            })
            .onAppear{
                data = items.first?.eatenFoodsArray ?? []
            }
        
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(maxSugar: .constant(0)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
