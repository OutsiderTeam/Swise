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

func addEatenFood(food: FoodDetail, index: Int, totalSugar: Double, totalCalories: Double, sugarCondition: Double) {
    let historyFood = HistoryFoods(context: viewContext)
    historyFood.foodId = food.foodId
    historyFood.brandName = food.brandName
    historyFood.foodType = food.foodType
    historyFood.foodUrl = food.foodUrl
    historyFood.foodName = food.foodName
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
    newItem.eatenFoods?.totalSugar = totalSugar + (Double(food.servings.serving![index].sugar ?? "0") ?? 0)
    newItem.eatenFoods?.totalSugar = totalSugar
    newItem.eatenFoods?.totalCalories = totalCalories
    newItem.servingFood?.addedSugars = food.servings.serving?[index].addedSugars
    newItem.servingFood?.calcium = food.servings.serving?[index].calcium
    newItem.servingFood?.calories = food.servings.serving?[index].calories
    newItem.servingFood?.carbohydrate = food.servings.serving?[index].carbohydrate
    newItem.servingFood?.cholesterol = food.servings.serving?[index].cholesterol
    newItem.servingFood?.fat = food.servings.serving?[index].fat
    newItem.servingFood?.fiber = food.servings.serving?[index].fiber
    newItem.servingFood?.iron = food.servings.serving?[index].iron
    newItem.servingFood?.measurementDescription = food.servings.serving?[index].measurementDescription
    newItem.servingFood?.metricServingAmount = food.servings.serving?[index].metricServingAmount
    newItem.servingFood?.metricServingUnit = food.servings.serving?[index].metricServingUnit
    newItem.servingFood?.monounsaturatedFat = food.servings.serving?[index].monounsaturatedFat
    newItem.servingFood?.numberOfUnits = food.servings.serving?[index].numberOfUnits
    newItem.servingFood?.polyunsaturatedFat = food.servings.serving?[index].polyunsaturatedFat
    newItem.servingFood?.potassium = food.servings.serving?[index].potassium
    newItem.servingFood?.protein = food.servings.serving?[index].protein
    newItem.servingFood?.saturatedFat = food.servings.serving?[index].saturatedFat
    newItem.servingFood?.servingDescription = food.servings.serving?[index].servingDescription
    newItem.servingFood?.servingId = food.servings.serving?[index].servingId
    newItem.servingFood?.servingUrl = food.servings.serving?[index].servingUrl
    newItem.servingFood?.sodium = food.servings.serving?[index].sodium
    newItem.servingFood?.sugar = food.servings.serving?[index].sugar
    newItem.servingFood?.transFat = food.servings.serving?[index].transFat
    newItem.servingFood?.vitaminA = food.servings.serving?[index].vitaminA
    newItem.servingFood?.vitaminC = food.servings.serving?[index].vitaminC
    newItem.servingFood?.vitaminD = food.servings.serving?[index].vitaminD
    
    do {
        try viewContext.save()
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    
}
