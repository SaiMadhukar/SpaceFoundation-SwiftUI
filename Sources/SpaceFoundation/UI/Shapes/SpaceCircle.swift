//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/13/24.
//

import SwiftUI

public struct SpaceCircle: View {
    
    private var width: CGFloat
    private var height: CGFloat
    private var rectange: CGFloat

    public init(
        width: CGFloat = 400,
        height: CGFloat = 400,
        rectange: CGFloat = 50
    ) {
        self.width = width
        self.height = height
        self.rectange = rectange
    }
    
    public var body: some View {
        customPath
    }
    
    var customPath: some View {
        Path { path in
            path.move(to: .init(x: 0, y: 0))
            path.addLine(to: .init(x: 0, y: rectange))
            
            path.addArc(
                center: .init(x: width / 2, y: rectange),
                radius: width * 0.6,
                startAngle: .zero,
                endAngle: .degrees(180),
                clockwise: false)
            
            path.addLine(to: .init(x: width, y: rectange))
            
            path.addLine(to: .init(x: width, y: 0))
            
            path.closeSubpath()
        }
        .fill(SpaceGradient.purpleBlueLinear.rStyle(), strokeColor: .purple, stroke: .init(lineWidth: 0))
    }
}


#Preview {
    SpaceCircle()
}
