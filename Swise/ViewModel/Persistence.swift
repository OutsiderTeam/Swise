//
//  Persistence.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

import CoreData

struct PersistenceController {
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

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Swise")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error.localizedDescription), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
    
    //********************************************************//
    //  This Function used for add Eaten Food to Core Data    //
    //********************************************************//

    func addEatenFood(food: FoodDetail, index: Int, totalSugar: Double, totalCalories: Double, sugarCondition: Double) -> String {
        let i = index >= 0 ? index : 0
        if index > 0 {
            let historyFood = HistoryFoods(context: container.viewContext)
            historyFood.foodId = food.foodId
            historyFood.brandName = food.brandName
            historyFood.foodType = food.foodType
            historyFood.foodUrl = food.foodUrl
            historyFood.foodName = food.foodName
        }
        let newItem = EatenFoods(context: container.viewContext)
        newItem.time = Date().formatted(date: .omitted, time: .shortened)
        newItem.brandName = food.brandName
        newItem.foodId = food.foodId
        newItem.foodName = food.foodName
        newItem.foodType = food.foodType
        newItem.foodUrl = food.foodUrl
        newItem.timestamp = Date()
        newItem.eatenFoods = DataItem(context: container.viewContext)
        newItem.eatenFoods?.date = Date().formatted(date: .complete, time: .omitted)
        newItem.eatenFoods?.sugarCondition = sugarCondition
        newItem.eatenFoods?.timestamp = Date()
        newItem.eatenFoods?.totalSugar = totalSugar
        newItem.eatenFoods?.totalCalories = totalCalories
        newItem.servingFood = ServingFood(context: container.viewContext)
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
        do {
            try container.viewContext.save()
            return "Your food sucessfully added"
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            return "Unresolved error \(nsError), \(nsError.userInfo)"
        }
        
    }

}
