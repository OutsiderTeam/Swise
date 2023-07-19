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
    @Published var activityIntensity: String = ""
    
    // Function to calculate the user's calorie needs
    func calorieNeed(heightData: Double, ageData: Int, sexData: String) -> Double{
        // Retrieve user info
        let height = heightData
        let age = Double(ageData)
        let sex = sexData
        
        // BBI : Berat Badan Ideal
        var BBI: Double = 0
        // BMR : Basal Metabolic Rate / Kalori yang dibutuhkan tubuh
        var BMR: Double = 0
        // calNeed: Kalori yang dibutuhkan tubuh berdasarkan exercise
        var calNeed: Double = 0
        
        switch sex{
        // When user as a female
        case "Female":
            //1. Calculate BBI
            BBI = (height-100)-((15*(height-100))/100)
            //2. Calculate BMR
            BMR = 66.5 + (9.6*BBI) + (1.8*height) - (4.7*age)
            //3. Calculate base on user's exercise
            calNeed = calculateByActivityIntensity(BMR: BMR)
            return calNeed
            
        //When user as a male
        case "Male":
            //1. Calculate BBI
            BBI = (height-100)-((10*(height-100))/100)
            //2. Calculate BMR
            BMR = 66.5 + (13.7*BBI) + (5*height) - (6.8*age)
            //3. Calculate base on user's exercise
            calNeed = calculateByActivityIntensity(BMR: BMR)
            return calNeed
            
        //When user gak jelas
        default:
            print("Tentuin lu Male apa Female bang")
            BBI = 0
            return BBI
        }
    }
    
    // Function to define the calculation base on user exercise routine
    func calculateByActivityIntensity(BMR: Double) -> Double{
        switch activityIntensity{
        case "No Exercise":
            return BMR*1.2
        case "Light":
            return BMR*1.375
        case "Moderate (3-5 days/week)":
            return BMR*1.55
        case "Very active (5-6 days/week)":
            return BMR*1.725
        case "Very Active/Physical Job":
            return BMR*1.9
        default :
            return BMR
        }
    }
    

    
    //Function to calculate max sugar intake
    func calculateMaxSugar(){
        
    }
    
}
