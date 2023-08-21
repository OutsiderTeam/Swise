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
    @NSManaged public var calories: String?
    @NSManaged public var measurementDescription: String?
    @NSManaged public var metricServingAmount: String?
    @NSManaged public var metricServingUnit: String?
    @NSManaged public var numberOfUnits: String?
    @NSManaged public var servingDescription: String?
    @NSManaged public var servingId: String?
    @NSManaged public var servingUrl: String?
    @NSManaged public var sugar: String?
    @NSManaged public var servingFood: EatenFoods?

    public var wrappedAddedSugars: String {
        addedSugars ?? "Unknown addedSugars"
    }
    public var wrappedCalories: String {
        calories ?? "Unknown calories"
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
    public var wrappedNumberOfUnits: String {
        numberOfUnits ?? "Unknown numberOfUnits"
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
    public var wrappedSugar: String {
        sugar ?? "Unknown sugar"
    }
}

extension ServingFood : Identifiable {

}
