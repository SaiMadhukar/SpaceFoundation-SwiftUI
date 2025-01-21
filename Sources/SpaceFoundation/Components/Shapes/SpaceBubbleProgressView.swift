//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/20/25.
//

import Foundation
import SwiftUI

public struct SpaceBubbleProgressView: View {
    
    @Environment(\.windowSize) var screenSize: CGSize
    @State private var isAnimating: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            
            Color.black.opacity(0.15)
            
            circleAnimation
                .frame(width: 200, height: 200)
                .foreground(SpaceColors.blue90)
        }
        .ignoresSafeArea()
        .frame(width: screenSize.width, height: screenSize.height)
    }
    
    private var circleAnimation: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(measureScale(index: index))
                        .offset(y: measureYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(
                        Animation.timingCurve(
                            0.5, 0.15 + Double(index) / 5, 0.25, 0.25,
                            duration: 1.25
                        )
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
        .drawingGroup()
    }
    
    func measureScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func measureYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}

#Preview {
    SpaceBubbleProgressView()
        .frame(width: 200, height: 200)
}
