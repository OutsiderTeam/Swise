//
//  CustomNavBar.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import Foundation
import SwiftUI
import UIKit

extension UINavigationController{
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.layer.cornerRadius = 30
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.navigationController?.navigationBar.clipsToBounds = true
        
        let app = UINavigationBarAppearance()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
        app.backgroundColor = UIColor(Color("bg_yellow"))
        
        self.navigationController?.navigationBar.standardAppearance = app
        self.navigationController?.navigationBar.compactAppearance = app
        self.navigationController?.navigationBar.scrollEdgeAppearance = app
    }
    
    
    
}
