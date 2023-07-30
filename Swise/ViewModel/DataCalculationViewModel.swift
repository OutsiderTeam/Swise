//
//  DataCalculationViewModel.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 17/07/23.
//

import Foundation
import SwiftUI
import HealthKit

//********************************************************//
//      This View Model used for manage Calculation       //
//           for User Calorie and Sugar intake            //
//********************************************************//


class DataCalculationViewModel: ObservableObject{
    private var healthKitManager = HealthKitManager()
    private var healthStore = HKHealthStore()
    // variable for retrieve user's exercise info
    @Published var activityIntensity: Activity = .no
    @Published var height: Double = 0
    @Published var weight: Double = 0
    @Published var age: Double = 0
    @Published var sex: Sex = .notRetrived
    @Published var allFilled: Bool = false
    @Published var showAlert: Bool = false
    
    // Every 1 tea spoon sugar = 5 gram sugar
    let gramTeaSpoon: Double = 4
    // Every 1 tea spoon sugar = 16 kkal
    let caloryTeaSpoon: Double = 16
    
    func healthRequest() {
        allFilled = false
        let dataSampleType = sampleType()
        healthKitManager.requestAccess {
            self.readHealthKitData(types: dataSampleType)
        }
    }
    
    private func sampleType() -> Set<HKObjectType> {
        return Set(arrayLiteral:
                    HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                   HKSampleType.quantityType (forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        )
    }
    
    func getDateOfBirth() {
        do {
            let dateOfBirth = try healthStore.dateOfBirthComponents()
            if let birthdate = dateOfBirth.date {
                // Calculate the age based on the birthdate
                DispatchQueue.main.async {
                    let now = Date()
                    let calendar = Calendar.current
                    let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
                    self.age = Double(ageComponents.year ?? 0)
                }
                // Use the calculated age as needed
            } else {
                // The date of birth is not available
            }
        } catch {
            // An error occurred while fetching the date of birth
        }
    }
    
    func getSex() {
        do {
            let biologicalSexObject = try healthStore.biologicalSex()
            let biologicalSex = biologicalSexObject.biologicalSex
            // Process the biological sex data as needed
            DispatchQueue.main.async {
                switch biologicalSex {
                case .female:
                    // User is female
                    self.sex = .female
                    break
                case .male:
                    // User is male
                    self.sex = .male
                    break
                case .other:
                    // User's biological sex is something other than male or female
                    self.sex = .other
                    break
                case .notSet:
                    // User's biological sex is not set
                    self.sex = .notRetrived
                    break
                @unknown default:
                    break
                }
                self.sex = self.sex
            }
        } catch {
            // An error occurred while fetching the biological sex
        }
    }
    
    func readHealthKitData(types: Set<HKObjectType>) {
        for type in types {
            guard let sampleType = type as? HKSampleType else { continue }
            let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { hkquery, results, error in
                DispatchQueue.main.async {
                    if let result = results as? [HKQuantitySample] {
                        for res in result {
                            if res.quantityType == HKQuantityType(.height) {
                                self.height = res.quantity.doubleValue(for: HKUnit.meter())
                                self.height = self.height * 100
                            } else if res.quantityType == HKQuantityType(.bodyMass) {
                                self.weight = res.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                            }
                            // Process the height data as needed
                        }
                    } else {
                        // An error occurred while fetching height data
                    }
                    
                }
            }
            healthStore.execute(query)
            healthStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { success, error in
            }
        }
        getDateOfBirth()
        getSex()
        self.healthChecker()
    }
    
    func healthChecker() {
        if (height == 0 || age == 0 || (sex == .notRetrived || sex == .other)){
            DispatchQueue.main.async {
                self.allFilled = false
                self.showAlert = true
            }
        } else {
            DispatchQueue.main.async {
                self.allFilled = true
                self.showAlert = false
            }
        }
        
    }
    
    // Function to calculate the user's calorie needs
    func calorieNeed() -> Double{
        // BBI : Berat Badan Ideal
        var BBI: Double = 0
        // BMR : Basal Metabolic Rate / Kalori yang dibutuhkan tubuh
        var BMR: Double = 0
        // calNeed: Kalori yang dibutuhkan tubuh berdasarkan exercise
        var calNeed: Double = 0
        if allFilled{
            switch sex{
                // When user as a female
            case .female:
                //1. Calculate BBI
                BBI = (height-100)-((15*(height-100))/100)
                //2. Calculate BMR
                BMR = 665 + (9.6*BBI) + (1.8*height) - (4.7*age)
                //3. Calculate base on user's exercise
                calNeed = calculateByActivityIntensity(BMR: BMR)
                //                return calNeed
                
                //When user as a male
            case .male:
                //1. Calculate BBI
                BBI = (height-100)-((10*(height-100))/100)
                //2. Calculate BMR
                BMR = 66 + (13.7*BBI) + (5*height) - (6.8*age)
                //3. Calculate base on user's exercise
                calNeed = calculateByActivityIntensity(BMR: BMR)
                //                return calNeed
                
                //When user's sex not detected
            default:
                calNeed = 0
            }
        }
        return calNeed
    }
    
    // Function to define the calculation base on user exercise routine
    func calculateByActivityIntensity(BMR: Double) -> Double{
        switch activityIntensity{
        case .no:
            return BMR*1.2
        case .light:
            return BMR*1.375
        case .moderate:
            return BMR*1.55
        case .very:
            return BMR*1.725
        case .extra:
            return BMR*1.9
        }
    }
    
    //Function to calculate max sugar intake
    func calculateMaxSugar(calorie: Double)->Int{
        var maxSugar: Int = 0
        if calorie <= calorieNeed() {
            maxSugar = Int(calorie*0.1*gramTeaSpoon/caloryTeaSpoon)
        } else if calorieNeed() == 0 {
            maxSugar = 0
        } else{
            maxSugar = Int(calorieNeed()*0.1*gramTeaSpoon/caloryTeaSpoon)
        }
        return maxSugar
        
        
    }
    
    // Function to calculate sugar as a tea spoon
    func calculateTeaSpoonOfSugar(sugar:Double)->Int{
        var teaSpoonSugar: Int = 0
        if sugar == 0{
            teaSpoonSugar = 0
        } else {
            teaSpoonSugar = Int(sugar/gramTeaSpoon)
        }
        return teaSpoonSugar
        
    }
    
}
