//
//  Foods.swift
//  Swise
//
//  Created by Agfid Prasetyo on 13/07/23.
//

struct FoodsResponse: Codable {
    public let foods: Foods
}

struct Foods: Codable {
    public let maxResults: String?
    public let pageNumber: String?
    public let totalResults: String?
    public let food: [Food]?
}

struct Food: Codable {
    public let foodDescription: String
    public let foodId: String
    public let foodName: String
    public let foodType: String
    public let foodUrl: String
}

struct FoodDetailResponse: Codable {
    public let food: FoodDetail
}

struct FoodDetail: Codable {
    public let brandName: String?
    public let foodId: String
    public let foodName: String
    public let foodType: String
    public let foodUrl: String
    public let servings: Servings
}

struct Servings: Codable {
    public let serving: [Serving]?
}

struct Serving: Codable {
    public let calcium: String?
    public let calories: String?
    public let carbohydrate: String?
    public let cholesterol: String?
    public let fat: String?
    public let fiber: String?
    public let iron: String?
    public let measurementDescription: String?
    public let metricServingAmount: String?
    public let metricServingUnit: String?
    public let monounsaturatedFat: String?
    public let numberOfUnits: String?
    public let polyunsaturatedFat: String?
    public let potassium: String?
    public let protein: String?
    public let saturatedFat: String?
    public let servingDescription: String
    public let servingId: String
    public let servingUrl: String
    public let sodium: String?
    public let sugar: String?
    public let addedSugars: String?
    public let vitaminA: String?
    public let vitaminC: String?
    public let vitaminD: String?
    public let transFat: String?
}

public struct FSError: Codable {
    let code: Int
    let message: String?
}
