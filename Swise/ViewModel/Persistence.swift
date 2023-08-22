//
//  Persistence.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import CoreData

class PersistenceController: ObservableObject {
    @Published var totalSugar: Double = 0
    @Published var totalCalories: Double = 0
    @Published var sugarCondition: Double = 0
    let container: NSPersistentContainer
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = DataItem(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Swise")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error.localizedDescription), \(error.userInfo)")
            }
        })
    }

    func fetchAll() -> [DataItem] {
        let fetchRequest = DataItem.fetchRequest()
        let dataItems = try? container.viewContext.fetch(fetchRequest)
        if dataItems?.isEmpty != true {
            let dataOnThisDay = dataItems?.filter {$0.date == Date().formatted(date: .complete, time: .omitted)}.first
            self.totalSugar = dataOnThisDay?.totalSugar ?? 0
            self.totalCalories = dataOnThisDay?.totalCalories ?? 0
            self.sugarCondition = dataOnThisDay?.sugarCondition ?? 0
        }
        return dataItems ?? []
    }
    
    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
    
    func save() -> String {
        let viewContext = container.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                return "Your food sucessfully added"
            } catch {
                let nsError = error as NSError
                return "Unresolved error \(nsError), \(nsError.userInfo)"
            }
        } else {
            return "No Changed"
        }
    }
        
    /// Function Add Eaten Food to Core Data
    /// - Parameters:
    ///   - food: eaten food
    ///   - index: index of serving
    ///   - totalSugar: total sugar
    ///   - totalCalories: total calories
    ///   - sugarCondition: sugar condition 0 = good, 1 = warning, 2 = danger
    /// - Returns: string message
    func addEatenFood(food: FoodDetail, index: Int) -> String {
        let viewContext = container.viewContext
        let i = index >= 0 ? index : 0
        if index > 0 {
            let historyFood = HistoryFoods(context: viewContext)
            historyFood.foodId = food.foodId
            historyFood.brandName = food.brandName
            historyFood.foodType = food.foodType
            historyFood.foodUrl = food.foodUrl
            historyFood.foodName = food.foodName
        }
        let newItem = EatenFoods(context: viewContext)
        newItem.time = Date().formatted(date: .omitted, time: .shortened)
        newItem.brandName = food.brandName
        newItem.foodId = food.foodId
        newItem.foodName = food.foodName
        newItem.foodType = food.foodType
        newItem.foodUrl = food.foodUrl
        newItem.timestamp = Date()
        newItem.eatenFoods = DataItem(context: viewContext)
        newItem.eatenFoods?.date = Date().formatted(date: .complete, time: .omitted)
        newItem.eatenFoods?.sugarCondition = sugarCondition
        newItem.eatenFoods?.timestamp = Date()
        newItem.eatenFoods?.totalSugar = totalSugar
        newItem.eatenFoods?.totalCalories = totalCalories
        newItem.servingFood = ServingFood(context: viewContext)
        newItem.servingFood?.addedSugars = food.servings.serving?[i].addedSugars
        newItem.servingFood?.calories = food.servings.serving?[i].calories
        newItem.servingFood?.measurementDescription = food.servings.serving?[i].measurementDescription
        newItem.servingFood?.metricServingAmount = food.servings.serving?[i].metricServingAmount
        newItem.servingFood?.metricServingUnit = food.servings.serving?[i].metricServingUnit
        newItem.servingFood?.numberOfUnits = food.servings.serving?[i].numberOfUnits
        newItem.servingFood?.servingDescription = food.servings.serving?[i].servingDescription
        newItem.servingFood?.servingId = food.servings.serving?[i].servingId
        newItem.servingFood?.servingUrl = food.servings.serving?[i].servingUrl
        newItem.servingFood?.sugar = food.servings.serving?[i].sugar
        return save()
//        do {
//            try container.viewContext.save()
//            return "Your food sucessfully added"
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            return "Unresolved error \(nsError), \(nsError.userInfo)"
//        }
        
    }

}
