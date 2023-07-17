//
//  ServingFood+CoreDataProperties.swift
//  Swise
//
//  Created by Agfid Prasetyo on 17/07/23.
//
//

import Foundation
import CoreData


extension ServingFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServingFood> {
        return NSFetchRequest<ServingFood>(entityName: "ServingFood")
    }

    @NSManaged public var addedSugars: String?
    @NSManaged public var calcium: String?
    @NSManaged public var calories: String?
    @NSManaged public var carbohydrate: String?
    @NSManaged public var fat: String?
    @NSManaged public var fiber: String?
    @NSManaged public var iron: String?
    @NSManaged public var cholesterol: String?
    @NSManaged public var measurementDescription: String?
    @NSManaged public var metricServingAmount: String?
    @NSManaged public var metricServingUnit: String?
    @NSManaged public var monounsaturatedFat: String?
    @NSManaged public var numberOfUnits: String?
    @NSManaged public var polyunsaturatedFat: String?
    @NSManaged public var potassium: String?
    @NSManaged public var protein: String?
    @NSManaged public var saturatedFat: String?
    @NSManaged public var servingDescription: String?
    @NSManaged public var servingId: String?
    @NSManaged public var servingUrl: String?
    @NSManaged public var sodium: String?
    @NSManaged public var sugar: String?
    @NSManaged public var transFat: String?
    @NSManaged public var vitaminA: String?
    @NSManaged public var vitaminC: String?
    @NSManaged public var vitaminD: String?
    @NSManaged public var servingFood: EatenFoods?

    public var wrappedAddedSugars: String {
        addedSugars ?? "Unknown addedSugars"
    }
    public var wrappedCalcium: String {
        calcium ?? "Unknown calcium"
    }
    public var wrappedCalories: String {
        calories ?? "Unknown calories"
    }
    public var WrappedCarbohydrate: String {
        carbohydrate ?? "Unknown carbohydrate"
    }
    public var wrappedCholesterol: String {
        cholesterol ?? "Unknown cholesterol"
    }
    public var wrappedFat: String {
        fat ?? "Unknown fat"
    }
    public var wrappedFiber: String {
        fiber ?? "Unknown fiber"
    }
    public var wrappedIron: String {
        iron ?? "Unknown iron"
    }
    public var wrappedMeasurementDescription: String {
        measurementDescription ?? "Unknown measurementDescription"
    }

    public var wrappedMetricServingAmount: String {
        metricServingAmount ?? "Unknown metricServingAmount"
    }

    public var wrappedMetricServingUnit: String {
        metricServingUnit ?? "Unknown metricServingUnit"
    }

    public var wrappedMonounsaturatedFat: String {
        monounsaturatedFat ?? "Unknown monounsaturatedFat"
    }

    public var wrappedNumberOfUnits: String {
        numberOfUnits ?? "Unknown numberOfUnits"
    }

    public var wrappedPolyunsaturatedFat: String {
        polyunsaturatedFat ?? "Unknown polyunsaturatedFat"
    }
    public var wrappedPotassium: String {
        potassium ?? "Unknown potassium"
    }
    public var wrappedProtein: String {
        protein ?? "Unknown protein"
    }
    public var wrappedSaturatedFat: String {
        saturatedFat ?? "Unknown saturatedFat"
    }
    public var wrappedServingDescription: String {
        servingDescription ?? "Unknown servingDescription"
    }
    public var wrappedServingId: String {
        servingId ?? "Unknown servingId"
    }
    public var wrappedServingUrl: String {
        servingUrl ?? "Unknown servingUrl"
    }
    public var wrappedSodium: String {
        sodium ?? "Unknown sodium"
    }
    public var wrappedSugar: String {
        sugar ?? "Unknown sugar"
    }
    public var wrappedTransFat: String {
        transFat ?? "Unknown transFat"
    }
    public var wrappedVitaminA: String {
        vitaminA ?? "Unknown vitaminA"
    }
    public var wrappedVitaminC: String {
        vitaminC ?? "Unknown vitaminC"
    }
    public var wrappedVitaminD: String {
        vitaminD ?? "Unknown vitaminD"
    }
}

extension ServingFood : Identifiable {

}
