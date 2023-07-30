//
//  AddFoodView.swift
//  Swise
//
//  Created by Mutiara Ruci on 19/07/23.
//

import SwiftUI
import SkeletonUI

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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryFoods.foodName, ascending: true)],
        animation: .default)
    private var historyFoods: FetchedResults<HistoryFoods>
    
    var calNeed: Double = 0
    @State var data: [EatenFoods] = []
    
    var body: some View {
        NavigationView {
            
            VStack{
                ZStack{
                    CustomNavBarContainerView(isSearch: true){
                        if text == "" {
                            ZStack {
                                VStack {
                                    VStack(alignment: .leading){
                                        Text("Your history food")
                                            .font(.headline)
                                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                                        if historyFoods.count > 0 {
                                            ScrollView(showsIndicators: false){
                                                ForEach(0..<(historyFoods.count <= 5 ? historyFoods.count : 5), id: \.self) { i in
                                                    HStack{
                                                        Text("\(historyFoods[i].foodName!)")
                                                        Spacer()
                                                        Image(systemName: "chevron.right")
                                                    }
                                                    .padding(20)
                                                    .background(Color("bg_yellow"))
                                                    .cornerRadius(10)
                                                    .onTapGesture {
                                                        viewModel.getFood(id: Int(historyFoods[i].foodId!)!)
                                                        isPresented = true
                                                    }

                                                }
                                            }
                                            .padding(.horizontal, 20)
                                            .frame(alignment: .top)
                                            .frame(maxHeight: .infinity)
                                        } else {
                                            VStack {
                                                EmptyListView(background: false)
                                            }
                                            .frame(maxHeight: .infinity)
                                            .frame(alignment: .center)
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
                                            }
                                            .foregroundColor(.white)
                                            .frame(width: 358, height: 50)
                                            .background(Color("button_color"))
                                            .cornerRadius(11)
                                            
                                        }
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1)
                                        .padding(.bottom, 20)
                                }
                                .frame(maxHeight: .infinity)
                            }
                        } else {
                            ZStack{
                                Color.white
                                    ScrollView(showsIndicators: false) {
                                        ForEach(viewModel.resultSearch, id: \.foodId) { food in
                                            HStack{
                                                Text(food.foodName)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                            .padding(20)
                                            .background(Color("bg_yellow")
                                            .cornerRadius(10)
                                            .padding(3))
                                            .skeleton(with: viewModel.isLoading, size: CGSize(width: UIScreen.main.bounds.width-40, height: 50))
                                            .shape(type: .rounded(.radius(5, style: .circular)))
                                            .animation(type: .linear())
                                            .onTapGesture {
                                                viewModel.getFood(id: Int(food.foodId)!)
                                                isPresented = true
                                            }
                                        }
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    .frame(alignment: .top)
                                    .frame(maxHeight: .infinity)
                                if viewModel.isEmpty {
                                    VStack {
                                        Image("empty_bowl")
                                        Text("Nothing to see here").font(.body)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 18, trailing: 20))
                                    .frame(width: UIScreen.main.bounds.width-40)
                                    .background(Color.clear)
                                    .cornerRadius(29)
                                }
                            }
                        }
                        
                    }
                    VStack{
                        CustomSearchView(text: $text, placeholder: "Search for a food").frame(alignment: .top)
                    }
                    .padding(.top, 15)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Add Food")
        .navigationDestination(isPresented: $isPresented) {
            FoodInformationView(maxSugar: $maxSugar, totalSugar: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalSugar ?? 0, totalCalories: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalCalories ?? 0, calNeed: calNeed)
        }
        
        .navigationDestination(isPresented: $foodManual) {
            AddNewFoodView(maxSugar: $maxSugar, totalSugar: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalSugar ?? 0, totalCalories: items.isEmpty ? 0 : items.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first?.totalCalories ?? 0, calNeed: calNeed)
        }
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
