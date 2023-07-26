//
//  HealthKitHelper.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 17/07/23.
//

import Foundation
import HealthKit
import SwiftUI

//********************************************************//
//     This Function used for manage HealthKit Data       //
//********************************************************//

class HealthKitHelper: ObservableObject{
    let healthStore = HKHealthStore()
    @Published var age: Int = 0
    @Published var sex: Sex = .notRetrived
    @Published var weight: Double = 0
    @Published var height: Double = 0
    @Published var healthApprove: Bool = false
    
    @StateObject private var calculationViewModel  = DataCalculationViewModel()
    
    
    // Request authorization to access Healthkit.
    func requestAuthorization() {
        // Check availability healthkit in your device
        if HKHealthStore.isHealthDataAvailable(){
            let typesToRead: Set = [
                HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
                HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
                HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                HKSampleType.quantityType (forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
            ]
            
            // Request authorization for those quantity types
            healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
                // Handle error.
                if success{
                    self.readHeightData()
                    self.readWeightData()
                    self.readAgeData()
                    self.readSexData()
                    if !self.healthApprove {
                        DispatchQueue.main.async {
                            self.healthApprove = true
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    func readHeightData(){
        // Define the height type
        guard let heightType = HKSampleType.quantityType(forIdentifier: .height) else {
            // Handle the case where the height type is not available
            return
        }

        // Create a height query
        let heightQuery = HKSampleQuery(sampleType: heightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            DispatchQueue.main.async {
                if let heightSamples = results as? [HKQuantitySample] {
                    // Handle the height samples retrieved
                    for heightSample in heightSamples {
                        self.height = heightSample.quantity.doubleValue(for: HKUnit.meter())
                        self.height = self.height * 100
                        // Process the height data as needed
                    }
                } else {
                    // An error occurred while fetching height data
                }
            
            }
            
        }
        healthStore.execute(heightQuery)
    }
    
    func readWeightData(){
        // Define the weight type
        guard let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            // Handle the case where the weight type is not available
            return
        }

        // Create a weight query
        let weightQuery = HKSampleQuery(sampleType: weightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            DispatchQueue.main.async {
                if let weightSamples = results as? [HKQuantitySample] {
                    // Handle the weight samples retrieved
                    for weightSample in weightSamples {
                        self.weight = weightSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                        // Process the weight data as needed
                    }
                } else {
                    // An error occurred while fetching weight data
                }
            }
        }

        // Execute the weight query
        healthStore.execute(weightQuery)
    }
    
    func readAgeData(){
        do {
            let dateOfBirth = try healthStore.dateOfBirthComponents()
            if let birthdate = dateOfBirth.date {
                // Calculate the age based on the birthdate
                DispatchQueue.main.async {
                    let now = Date()
                    let calendar = Calendar.current
                    let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
                    self.age = ageComponents.year ?? 0
                }
                // Use the calculated age as needed
            } else {
                // The date of birth is not available
            }
        } catch {
            // An error occurred while fetching the date of birth
        }
    }
    
    func readSexData(){
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
            }
        } catch {
            // An error occurred while fetching the biological sex
        }
    }
}
