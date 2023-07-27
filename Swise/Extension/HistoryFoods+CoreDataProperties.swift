//
//  HistoryFoods+CoreDataProperties.swift
//  Swise
//
//  Created by Agfid Prasetyo on 19/07/23.
//
//

import Foundation
import CoreData


extension HistoryFoods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryFoods> {
        return NSFetchRequest<HistoryFoods>(entityName: "HistoryFoods")
    }

    @NSManaged public var brandName: String?
    @NSManaged public var foodId: String?
    @NSManaged public var foodName: String?
    @NSManaged public var foodType: String?
    @NSManaged public var foodUrl: String?

}

extension HistoryFoods : Identifiable {

}
