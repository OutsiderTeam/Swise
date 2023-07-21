//
//  AddFoodView.swift
//  Swise
//
//  Created by Mutiara Ruci on 19/07/23.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var viewModel: FoodViewModel
    @State var text: String = ""
    @State var isPresented: Bool = false
    @State private var isEditing = false
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<DataItem>
    
    var body: some View {
        VStack{
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
                    
                }){
                    HStack{
                        Image(systemName: "plus.circle")
                        Text("Add your food manually")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }.foregroundColor(.white).frame(width: 358, height: 50).background(Color("button_color")).cornerRadius(11)
                    
                }.padding()
            
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
        
        .navigationTitle("Add Food")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $text)
        .onSubmit(of: .search) {
            viewModel.searchFood(query: text)
        }
        
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(FoodViewModel(foodService: FoodStore.shared))
    }
}
