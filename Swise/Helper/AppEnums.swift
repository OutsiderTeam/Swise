//
//  AppEnums.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 24/07/23.
//

import Foundation
import SwiftUI

enum Sex: String{
    case female = "Female"
    case male = "Male"
    case other = "Other"
    case notRetrived = "Not Retrived"
}

enum Activity: String, CaseIterable, Identifiable{
    case no = "Sedentary"
    case light = "Lightly Active"
    case moderate = "Moderately Active"
    case very = "Very Active"
    case extra = "Extra Active"
    
    var id : String { self.rawValue }
}

struct OnBoarding{
    var title: String
    var description: String
    var icon: String
}

struct ActivityDetail{
    var activity: Activity
    var description: String
}
