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
//        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//        self.navigationController?.navigationBar.layer.cornerRadius = 30
//        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        self.navigationController?.navigationBar.clipsToBounds = true
//
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.isOpaque = true
//        let app = UINavigationBarAppearance()
//        app.backgroundColor = UIColor(Color("bg_blue"))
//        app.backgroundImage = UIImage()

//        self.navigationController?.navigationBar.standardAppearance = app
//        self.navigationController?.navigationBar.compactAppearance = app
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app
    }



}

//struct CustomNavigationBarShape: Shape {
//    var cornerRadius: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: 0, y: rect.height))
//        path.addLine(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: rect.width, y: 0))
//        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
//
//        // Customize the shape's corners
//        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
//                    radius: cornerRadius,
//                    startAngle: Angle(degrees: -90),
//                    endAngle: Angle(degrees: 0),
//                    clockwise: false)
//        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
//                    radius: cornerRadius,
//                    startAngle: Angle(degrees: 0),
//                    endAngle: Angle(degrees: 90),
//                    clockwise: false)
//
//        return path
//    }
//}
//
//extension UINavigationBarAppearance {
//    static var customAppearance: UINavigationBarAppearance {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.red // Set your desired custom color here
//
//        // Create a rounded corner for the navigation bar
//        let cornerRadius: CGFloat = 20.0
//        appearance.backgroundImage = UIImage(named: "smily_sugar")
//
//        return appearance
//    }
//}
//
//extension UIImage {
//    static func image(withRoundedCorners cornerRadius: CGFloat, color: UIColor) -> UIImage {
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
//        return renderer.image { context in
//            let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
//            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//            color.setFill()
//            path.fill()
//        }
//    }
//}

