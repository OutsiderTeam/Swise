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
    
    func testFetchCoreData() throws {
        let coreDataItems = dataController.fetchAll()
        XCTAssertEqual(coreDataItems.count, 0)
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

    func testAddEatenFoodAndValidateCaloriesValueCoreData() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 0
        dataController.totalCalories = 150
        dataController.totalSugar = 1
        let message = dataController.addEatenFood(food: food, index: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), 1)
        let allData = dataController.fetchAll().first
        XCTAssertEqual(allData?.totalCalories, 150)
    }

    func testAddEatenFoodAndValidateSugarValueCoreData() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 0
        dataController.totalCalories = 100
        dataController.totalSugar = 2
        let message = dataController.addEatenFood(food: food, index: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), 1)
        let allData = dataController.fetchAll().first
        XCTAssertEqual(allData?.totalSugar, 2)
    }

    func testAddEatenFoodAndValidateSugarConditionValueCoreData() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 1
        dataController.totalCalories = 100
        dataController.totalSugar = 5
        let message = dataController.addEatenFood(food: food, index: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), 1)
        let allData = dataController.fetchAll().first
        XCTAssertEqual(allData?.sugarCondition, 1)
    }

    func testAddEatenFoodAndValidateAllValueCoreData() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        dataController.sugarCondition = 0
        dataController.totalCalories = 10
        dataController.totalSugar = 1
        let message = dataController.addEatenFood(food: food, index: 0)
        XCTAssertEqual(message, "Your food sucessfully added")
        XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), 1)
        XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), 1)
        let allData = dataController.fetchAll().first
        XCTAssertEqual(allData?.totalCalories, 10)
        XCTAssertEqual(allData?.totalSugar, 1)
        XCTAssertEqual(allData?.sugarCondition, 0)
    }

    func testAddEatenFoodRepeat() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        for index in 1...10 {
            dataController.sugarCondition += 0
            dataController.totalCalories += 10
            dataController.totalSugar += 1
            let message = dataController.addEatenFood(food: food, index: 0)
            XCTAssertEqual(message, "Your food sucessfully added")
            XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
            XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), index)
            XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), index)
        }
    }

    func testAddEatenFoodRepeatAndValidateAllValueCoreData() throws {
        let food: FoodDetail = FoodDetail(foodId: "", foodName: "", foodType: "", foodUrl: "", servings: Servings(serving: [Serving(servingDescription: "", servingId: "", servingUrl: "")]))
        for index in 1...10 {
            dataController.sugarCondition += 0
            dataController.totalCalories += 150
            dataController.totalSugar += 1
            let message = dataController.addEatenFood(food: food, index: 0)
            XCTAssertEqual(message, "Your food sucessfully added")
            XCTAssertEqual(dataController.count(for: DataItem.fetchRequest()), 1)
            XCTAssertEqual(dataController.count(for: EatenFoods.fetchRequest()), index)
            XCTAssertEqual(dataController.count(for: ServingFood.fetchRequest()), index)
        }
        let allData = dataController.fetchAll().first
        XCTAssertEqual(allData?.totalCalories, 1500)
        XCTAssertEqual(allData?.totalSugar, 10)
        XCTAssertEqual(allData?.sugarCondition, 0)
    }
    
}
