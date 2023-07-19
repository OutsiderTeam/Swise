//
//  EatenFoods+CoreDataProperties.swift
//  Swise
//
//  Created by Agfid Prasetyo on 17/07/23.
//
//

import Foundation
import CoreData


extension EatenFoods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EatenFoods> {
        return NSFetchRequest<EatenFoods>(entityName: "EatenFoods")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var brandName: String?
    @NSManaged public var foodName: String?
    @NSManaged public var foodId: String?
    @NSManaged public var foodType: String?
    @NSManaged public var foodUrl: String?
    @NSManaged public var eatenFoods: DataItem?
    @NSManaged public var servingFood: ServingFood?
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    public var wrappedBrandName: String {
        brandName ?? "Unknown Brand Name"
    }
    public var wrappedFoodId: String {
        foodId ?? "Unknown Food Id"
    }
    public var wrappedFoodName: String {
        foodName ?? "Unknown Food Name"
    }
    public var wrappedFoodType: String {
        foodType ?? "Unknown Food Type"
    }
    public var wrappedFoodUrl: String {
        foodUrl ?? "Unknown Food Url"
    }

}

extension EatenFoods : Identifiable {

}
