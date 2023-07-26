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
    case no = "No Exercise"
    case light = "Light"
    case moderate = "Moderate (3-5 days/week)"
    case very = "Very active (5-6 days/week)"
    case extra = "Extra active (Very Active/Physical Job)"
    
    var id : String { self.rawValue }
}
