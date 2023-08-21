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
    
    func testCountDataEmpty() throws {
        let dataCount = dataController.count(for: DataItem.fetchRequest())
        XCTAssertEqual(dataCount, 0)
        XCTAssertNotNil(dataCount)
    }
    
    func testSaveNoChanged() throws {
        let message = dataController.save()
        XCTAssertEqual(message, "No Changed")
    }

    func testAddEatenFood() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 0
        dataController.totalCalories = 10
        dataController.totalSugar = 1
        let message = dataController.addEatenFood(food: food, index: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), 1)
    }

    func testAddEatenFoodRepeat() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 0
        dataController.totalCalories = 10
        dataController.totalSugar = 1
        for index in 1...10 {
            let message = dataController.addEatenFood(food: food, index: 0)
            XCTAssertEqual(message, "Your food sucessfully added")
            XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
            XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), index)
            XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), index)
        }
    }
    
}
