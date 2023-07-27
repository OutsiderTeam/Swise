//
//  Foods.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

struct FoodsResponse: Codable {
    public var foods: Foods
}

struct Foods: Codable {
    public var maxResults: String?
    public var pageNumber: String?
    public var totalResults: String?
    public var food: [Food]?
}

struct Food: Codable {
    public var foodDescription: String
    public var foodId: String
    public var foodName: String
    public var foodType: String
    public var foodUrl: String
}

struct FoodDetailResponse: Codable {
    public var food: FoodDetail
}

struct FoodDetail: Codable {
    public var brandName: String?
    public var foodId: String
    public var foodName: String
    public var foodType: String
    public var foodUrl: String
    public var servings: Servings
}

struct Servings: Codable {
    public var serving: [Serving]?
}

struct Serving: Codable {
    public var calcium: String?
    public var calories: String?
    public var carbohydrate: String?
    public var cholesterol: String?
    public var fat: String?
    public var fiber: String?
    public var iron: String?
    public var measurementDescription: String?
    public var metricServingAmount: String?
    public var metricServingUnit: String?
    public var monounsaturatedFat: String?
    public var numberOfUnits: String?
    public var polyunsaturatedFat: String?
    public var potassium: String?
    public var protein: String?
    public var saturatedFat: String?
    public var servingDescription: String
    public var servingId: String
    public var servingUrl: String
    public var sodium: String?
    public var sugar: String?
    public var addedSugars: String?
    public var vitaminA: String?
    public var vitaminC: String?
    public var vitaminD: String?
    public var transFat: String?
}

public struct FSError: Codable {
    let code: Int
    let message: String?
}
