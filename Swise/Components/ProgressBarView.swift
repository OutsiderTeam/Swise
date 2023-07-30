//
//  ProgressBarView.swift
//  Swise
//
//  Created by Agfid Prasetyo on 25/07/23.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Float
    @Binding var total: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, total)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("button_color"))
                .rotationEffect(Angle(degrees: 270.0))
//                .animation(.linear)
                .animation(.linear, value: 1)
            
            Text(String(format: "%.0f %%", min(progress, total)*100.0))
                .font(.title3)
                .bold()
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: .constant(0), total: .constant(0))
    }
}
