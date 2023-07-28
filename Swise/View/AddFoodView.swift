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
    @State var isPresented: Bool = false
    var isSearch: Bool = true
    @State private var isEditing = false
    @State private var statusBar = UIStatusBarStyle.lightContent
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>
    var calNeed: Double = 0
    
    var body: some View {
        NavigationView {
            
            VStack{
                ZStack{
                    CustomNavBarContainerView(isSearch: isSearch){
                        if text == "" {
                            VStack(alignment: .leading){
                                Text("Your search history").font(.headline)
                                HStack{
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                }
                                HStack{
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                    ZStack{
                                        Text("Roti")
                                    }.frame(width: 81, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                }
                                
                            }.padding(.horizontal, 16)
                            
                            VStack(alignment: .leading){
                                Text("Your recent search").font(.headline)
                                VStack{
                                    ZStack{
                                        HStack{
                                            Text("Roti").padding(.trailing, 240)
                                            Image(systemName: "chevron.right")
                                        }
                                    }.frame(width: 361, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                    ZStack{
                                        HStack{
                                            Text("Roti").padding(.trailing, 240)
                                            Image(systemName: "chevron.right")
                                        }
                                    }.frame(width: 361, height: 47)
                                        .background(Color("bg_yellow"))
                                        .cornerRadius(15)
                                        .padding(.bottom, 9)
                                }
                                
                            }.padding(.horizontal, 16)
                            Spacer()
                            
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
                                    
                                }.padding()
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
                                            .listRowBackground(Color("bg_yellow").cornerRadius(20).padding(3))
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                    
                                    
                                    .scrollContentBackground(.hidden)
                                    .navigationDestination(isPresented: $isPresented) {
                                        DetailFoodView(maxSugar: $maxSugar, totalSugar: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalSugar ?? 0, totalCalories: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalCalories ?? 0, calNeed: calNeed)
                                    }
                                }
                            }
                        }
                        
                    }
                    VStack{
                        CustomSearchView(text: $text)
                        Spacer()
                    }
                }
                
                
            }
        }
            .navigationTitle("Add Food")
            
//            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(isPresented: $foodManual, destination: {
                AddNewFoodView()
            })
            .onChange(of: text, perform: { newValue in
                viewModel.searchFood(query: text)
            })
//            .onSubmit(of: .search) {
//                viewModel.searchFood(query: text)
//            }
        
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(maxSugar: .constant(0)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
