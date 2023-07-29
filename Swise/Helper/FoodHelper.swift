//
//  Food.swift
//  Swise
//
//  Created by Agfid Prasetyo on 16/07/23.
//

import Foundation

let viewContext = PersistenceController.shared.container.viewContext

//********************************************************//
//  This Function used for add Eaten Food to Core Data    //
//********************************************************//

func addEatenFood(food: FoodDetail, index: Int, totalSugar: Double, totalCalories: Double, sugarCondition: Double) -> Bool {
    let i = index >= 0 ? index : 0
    if index >= 0 {
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
    newItem.servingFood?.calcium = food.servings.serving?[i].calcium
    newItem.servingFood?.calories = food.servings.serving?[i].calories
    newItem.servingFood?.carbohydrate = food.servings.serving?[i].carbohydrate
    newItem.servingFood?.cholesterol = food.servings.serving?[i].cholesterol
    newItem.servingFood?.fat = food.servings.serving?[i].fat
    newItem.servingFood?.fiber = food.servings.serving?[i].fiber
    newItem.servingFood?.iron = food.servings.serving?[i].iron
    newItem.servingFood?.measurementDescription = food.servings.serving?[i].measurementDescription
    newItem.servingFood?.metricServingAmount = food.servings.serving?[i].metricServingAmount
    newItem.servingFood?.metricServingUnit = food.servings.serving?[i].metricServingUnit
    newItem.servingFood?.monounsaturatedFat = food.servings.serving?[i].monounsaturatedFat
    newItem.servingFood?.numberOfUnits = food.servings.serving?[i].numberOfUnits
    newItem.servingFood?.polyunsaturatedFat = food.servings.serving?[i].polyunsaturatedFat
    newItem.servingFood?.potassium = food.servings.serving?[i].potassium
    newItem.servingFood?.protein = food.servings.serving?[i].protein
    newItem.servingFood?.saturatedFat = food.servings.serving?[i].saturatedFat
    newItem.servingFood?.servingDescription = food.servings.serving?[i].servingDescription
    newItem.servingFood?.servingId = food.servings.serving?[i].servingId
    newItem.servingFood?.servingUrl = food.servings.serving?[i].servingUrl
    newItem.servingFood?.sodium = food.servings.serving?[i].sodium
    newItem.servingFood?.sugar = food.servings.serving?[i].sugar
    newItem.servingFood?.transFat = food.servings.serving?[i].transFat
    newItem.servingFood?.vitaminA = food.servings.serving?[i].vitaminA
    newItem.servingFood?.vitaminC = food.servings.serving?[i].vitaminC
    newItem.servingFood?.vitaminD = food.servings.serving?[i].vitaminD
    do {
        try viewContext.save()
        return true
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        print("Unresolved error \(nsError), \(nsError.userInfo)")
        return false
    }
    
}
