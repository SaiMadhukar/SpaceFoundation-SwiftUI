//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/13/24.
//

import SwiftUI

struct SpaceLogo: View {
    
    
    var body: some View {
        customPath
    }
    
    var customPath: some View {
        Path { path in
            path.move(to: .init(x: 200, y: 100))
            
            path.addArc(
                center: .init(x: 200, y: 100),
                radius: 100,
                startAngle: .zero,
                endAngle: .degrees(200),
                clockwise: false)
            
            path.closeSubpath()
            
            path.move(to: .init(x: 50, y: 300))
            
            path.addCurve(to: .init(x: 300, y: 300), control1: .init(x: 120, y: 200), control2: .init(x: 220, y: 400))
        }
        .stroke(Color.red, lineWidth: 5)
        .frame(width: 300, height: 500)
    }
}


#Preview {
    SpaceLogo()
}
