//
//  CustomNavBar.swift
//  Swise
//
//  Created by Ayu Lestari Ramadani on 26/07/23.
//

import Foundation
import SwiftUI
import UIKit

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct CustomHeaderView: View {
    var body: some View {
        Rectangle()
        .cornerRadius(29, corners: [.bottomLeft, .bottomRight])
            .frame(maxWidth: .infinity, maxHeight: 150)
            .foregroundColor(Color("bg_blue")).edgesIgnoringSafeArea(.top)
    }
}

extension UINavigationController{
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isOpaque = true
    }



}



