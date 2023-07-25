//
//  DataCalculationViewModel.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 17/07/23.
//

import Foundation
import SwiftUI

//********************************************************//
//      This View Model used for manage Calculation       //
//           for User Calorie and Sugar intake            //
//********************************************************//


class DataCalculationViewModel: ObservableObject{
    // variable for retrieve user's exercise info
    @Published var activityIntensity: Activity = .no
    @Published var height: Double = 0
    @Published var age: Double = 0
    @Published var sex: Sex = .notRetrived
    
    // Every 1 tea spoon sugar = 5 gram sugar
    let gramTeaSpoon: Double = 5
    // Every 1 tea spoon sugar = 16 kkal
    let caloryTeaSpoon: Double = 16
    
    func healthChecker()-> Bool{
        if (height == 0 && age == 0 && (sex == .notRetrived || sex == .other)){
            return false
        } else {
            return true
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
        if healthChecker(){
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
    func calculateTeaSpoonOfSugar(calorie:Double)->Int{
        var teaSpoonSugar: Int = 0
        if calorie == 0{
            teaSpoonSugar = 0
        } else {
            teaSpoonSugar = Int(calorie*0.1/caloryTeaSpoon)
        }
        return teaSpoonSugar
        
    }
    
}
