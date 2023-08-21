//
//  SwiseTests.swift
//  SwiseTests
//
//  Created by Agfid Prasetyo on 21/08/23.
//

import XCTest
@testable import Swise

final class SwiseTests: XCTestCase {
    var viewModel: DataCalculationViewModel!

    override func setUpWithError() throws {
        viewModel = DataCalculationViewModel()
    }

    func testCalorieNeedMale() throws {
        viewModel.activityIntensity = .no
        viewModel.sex = .male
        viewModel.height = 170
        viewModel.age = 21
        viewModel.weight = 45
        viewModel.allFilled = true
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertGreaterThan(calorieNeed, 1000)
        XCTAssertEqual(Int(calorieNeed), 1963)
    }

    func testCalorieNeedMaleEmptyHeight() throws {
        viewModel.sex = .male
        viewModel.height = 0
        viewModel.age = 21
        viewModel.weight = 45
        viewModel.allFilled = false
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertEqual(calorieNeed, 0)
    }

    func testCalorieNeedMaleEmptyAge() throws {
        viewModel.sex = .male
        viewModel.height = 170
        viewModel.age = 0
        viewModel.weight = 45
        viewModel.allFilled = false
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertEqual(calorieNeed, 0)
    }

    func testCalorieNeedFemale() throws {
        viewModel.activityIntensity = .no
        viewModel.sex = .female
        viewModel.height = 170
        viewModel.age = 21
        viewModel.weight = 45
        viewModel.allFilled = true
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertGreaterThan(calorieNeed, 1000)
        XCTAssertEqual(Int(calorieNeed), 1732)
    }

    func testCalorieNeedFemaleEmptyHeight() throws {
        viewModel.sex = .female
        viewModel.height = 0
        viewModel.age = 21
        viewModel.weight = 45
        viewModel.allFilled = false
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertEqual(calorieNeed, 0)
    }

    func testCalorieNeedFemaleEmptyAge() throws {
        viewModel.sex = .female
        viewModel.height = 180
        viewModel.age = 0
        viewModel.weight = 45
        viewModel.allFilled = false
        let calorieNeed = viewModel.calorieNeed()
        XCTAssertNotNil(calorieNeed)
        XCTAssertEqual(calorieNeed, 0)
    }
    
    func testCalculateByActivityIntensityNoActivity() throws {
        viewModel.activityIntensity = .no
        let BMRWithActivity = viewModel.calculateByActivityIntensity(BMR: 2249)
        XCTAssertEqual(Int(BMRWithActivity), 2698)
        XCTAssertNotNil(BMRWithActivity)
        XCTAssertGreaterThan(BMRWithActivity, 1000)
    }

    func testCalculateByActivityIntensityLightActivity() throws {
        viewModel.activityIntensity = .light
        let BMRWithActivity = viewModel.calculateByActivityIntensity(BMR: 2249)
        XCTAssertEqual(Int(BMRWithActivity), 3092)
        XCTAssertNotNil(BMRWithActivity)
        XCTAssertGreaterThan(BMRWithActivity, 1000)
    }

    func testCalculateByActivityIntensityModerateActivity() throws {
        viewModel.activityIntensity = .moderate
        let BMRWithActivity = viewModel.calculateByActivityIntensity(BMR: 2249)
        XCTAssertEqual(Int(BMRWithActivity), 3485)
        XCTAssertNotNil(BMRWithActivity)
        XCTAssertGreaterThan(BMRWithActivity, 1000)
    }

    func testCalculateByActivityIntensityVeryActivity() throws {
        viewModel.activityIntensity = .very
        let BMRWithActivity = viewModel.calculateByActivityIntensity(BMR: 2249)
        XCTAssertEqual(Int(BMRWithActivity), 3879)
        XCTAssertNotNil(BMRWithActivity)
        XCTAssertGreaterThan(BMRWithActivity, 1000)
    }
    func testCalculateByActivityIntensityExtraActivity() throws {
        viewModel.activityIntensity = .extra
        let BMRWithActivity = viewModel.calculateByActivityIntensity(BMR: 2249)
        XCTAssertEqual(Int(BMRWithActivity), 4273)
        XCTAssertNotNil(BMRWithActivity)
        XCTAssertGreaterThan(BMRWithActivity, 1000)
    }
    
    func testCalculateMaxSugar() throws {
        viewModel.activityIntensity = .no
        viewModel.height = 170
        viewModel.age = 21
        viewModel.sex = .male
        viewModel.allFilled = true
        let maxSugar = viewModel.calculateMaxSugar(calorie: 100)
        XCTAssertGreaterThan(maxSugar, 0)
        XCTAssertNotNil(maxSugar)
        XCTAssertEqual(maxSugar, 2)
    }
    
    func testCalculateMaxSugarCalNeedZero() throws {
        viewModel.activityIntensity = .no
        viewModel.height = 0
        viewModel.age = 21
        viewModel.sex = .male
        viewModel.allFilled = false
        let maxSugar = viewModel.calculateMaxSugar(calorie: 3000)
        XCTAssertNotNil(maxSugar)
        XCTAssertEqual(maxSugar, 0)
    }
    
    func testCalculateMaxSugarMoreThanCalNeed() throws {
        viewModel.activityIntensity = .no
        viewModel.height = 170
        viewModel.age = 21
        viewModel.sex = .male
        viewModel.allFilled = true
        let maxSugar = viewModel.calculateMaxSugar(calorie: 10000)
        XCTAssertGreaterThan(maxSugar, 0)
        XCTAssertNotNil(maxSugar)
        XCTAssertEqual(maxSugar, 49)
    }

    func testCalculateTeaSpoonOfSugar() throws {
        let teaSpoonSugar = viewModel.calculateTeaSpoonOfSugar(sugar: 8)
        XCTAssertGreaterThan(teaSpoonSugar, 0)
        XCTAssertNotNil(teaSpoonSugar)
        XCTAssertEqual(teaSpoonSugar, 2)
    }

    func testCalculateTeaSpoonOfSugarLessThanFourGrams() throws {
        let teaSpoonSugar = viewModel.calculateTeaSpoonOfSugar(sugar: 2)
        XCTAssertNotNil(teaSpoonSugar)
        XCTAssertEqual(teaSpoonSugar, 0)
    }
}
