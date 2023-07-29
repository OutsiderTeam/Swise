//
//  DataItem+CoreDataProperties.swift
//  Swise
//
//  Created by Agfid Prasetyo on 17/07/23.
//
//

import Foundation
import CoreData


extension DataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataItem> {
        return NSFetchRequest<DataItem>(entityName: "DataItem")
    }

    @NSManaged public var sugarCondition: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var date: String?
    @NSManaged public var totalSugar: Double
    @NSManaged public var totalCalories: Double
    @NSManaged public var eatenFoods: NSSet?
    
    public var wrappedDate: String {
        date ?? Date().formatted(date: .complete, time: .omitted)
    }
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    public var eatenFoodsArray: [EatenFoods] {
        let set = eatenFoods as? Set<EatenFoods> ?? []

        return set.sorted {
            $0.wrappedTimestamp > $1.wrappedTimestamp
        }
    }

}

// MARK: Generated accessors for eatenFoods
extension DataItem {

    @objc(addEatenFoodsObject:)
    @NSManaged public func addToEatenFoods(_ value: EatenFoods)

    @objc(removeEatenFoodsObject:)
    @NSManaged public func removeFromEatenFoods(_ value: EatenFoods)

    @objc(addEatenFoods:)
    @NSManaged public func addToEatenFoods(_ values: NSSet)

    @objc(removeEatenFoods:)
    @NSManaged public func removeFromEatenFoods(_ values: NSSet)

}

extension DataItem : Identifiable {

}
