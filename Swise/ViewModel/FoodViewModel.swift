//
//  FoodsViewModel.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import Foundation

class FoodViewModel: ObservableObject {
    private let foodService: FoodService
    @Published var isLoading: Bool = false
    @Published var foods: [Food] = []
    @Published var food: FoodDetail = FoodDetail(brandName: "", foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: []))
    @Published var resultSearch: [Food] = []
    
    
    init(foodService: FoodService) {
        self.foodService = foodService
    }
    
    func getFood(id: Int = -1) {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        isLoading = true
        queue.async(group: group) {
            group.enter()
            self.foodService.fetchFood(id: id) { response in
                DispatchQueue.main.async {
                    self.food = response.food
                }
//                Task {
//                    await self.setFood(food: response.food)
//                }
                group.leave()
            } errorHandler: { error in
                print(error.localizedDescription)
                group.leave()
            }
            
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
    
    func searchFood(query: String) {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        isLoading = true
        queue.async(group: group) {
            group.enter()
            self.foodService.searchFood(query: query) { response in
                DispatchQueue.main.async {
                    self.resultSearch = response.foods.food ?? []
                }
//                Task {
//                    await self.setSearchResult(results: response.foods.food ?? [])
//                }
                group.leave()
            } errorHandler: { error in
                print(error.localizedDescription)
                group.leave()
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
    
//    @MainActor func setFood(food: FoodDetail) {
//        self.food = food
//    }
    
//    @MainActor func setSearchResult(results: [Food]) {
//        resultSearch = results
//    }
}
