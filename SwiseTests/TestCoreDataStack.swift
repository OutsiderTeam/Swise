//
//  TestCoreDataStack.swift
//  SwiseTests
//
//  Created by Agfid Prasetyo on 21/08/23.
//

import XCTest
import CoreData
@testable import Swise

final class TestCoreDataStack: XCTestCase {
    var dataController: PersistenceController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = PersistenceController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

    func testAddEatenFood() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        let message = dataController.addEatenFood(food: food, index: 0, totalSugar: 0, totalCalories: 10, sugarCondition: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
    }
}
