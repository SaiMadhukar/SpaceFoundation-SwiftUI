//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/20/25.
//

import Foundation
import SwiftUI

public struct SpaceProgressView: View {
    
    @State private var progress: CGFloat = 0.0
    private let animationDuration: Double = 2.0
    
    @Environment(\.windowSize) var screen: CGSize
    @Environment(\.colorScheme) var scheme: ColorScheme
    
    public init() {}
    
    public var body: some View {
        fullScreen
    }
    
    public var fullScreen: some View {
        ZStack {
            loadingView
        }
        .frame(width: screen.width, height: screen.height)
        .background(SpaceColors.black10)
    }
    
    public var loadingView: some View {
        VStack {
            GeometryReader { geometry in
                let path = createCirclePath(in: geometry.size)

                ZStack {
                    path.stroke(style: StrokeStyle(lineWidth: 5, dash: [0, 20]))
                        
                    ForEach(0..<4) { index in
                        let offset = CGFloat(index) / 4.0
                        path.trim(from: progress + offset, to: progress + offset + 0.1)
                            .stroke(strokeColor, lineWidth: 5)
                            .animation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false), value: progress)
                    }
                }
                .onAppear {
                    progress = 1.0
                }
            }
        }
        .frame(width: 200, height: 200)
    }
    
    private var strokeColor: some ShapeStyle {
        if scheme == .dark {
            SpaceGradient.goldLightRadial.lStyle()
        } else {
            SpaceGradient.purpleGoldRadial.lStyle()
        }
    }
    
    private func createNestedPotPath(in size: CGSize) -> Path {
            var path = Path()
            let potWidth = size.width * 0.6
            let potHeight = size.height * 0.4
            let spacing: CGFloat = 10.0
            
            for i in 0..<3 {
                let inset = CGFloat(i) * spacing
                let potX = (size.width - potWidth) / 2 + inset
                let potY = (size.height - potHeight) / 2 + inset
                let currentWidth = potWidth - 2 * inset
                let currentHeight = potHeight - 2 * inset
                
                path.move(to: CGPoint(x: potX, y: potY))
                path.addLine(to: CGPoint(x: potX + currentWidth, y: potY))
                path.addLine(to: CGPoint(x: potX + currentWidth * 0.8, y: potY + currentHeight))
                path.addLine(to: CGPoint(x: potX + currentWidth * 0.2, y: potY + currentHeight))
                path.closeSubpath()
            }
            
            return path
    }
    
    private func createCirclePath(in size: CGSize) -> Path {
        var path = Path()
        let squareSize: CGFloat = 20.0
        let numberOfCircles = 3
        let spacing: CGFloat = 10.0
        
        for i in 0..<numberOfCircles {
            let inset = CGFloat(i) * (squareSize + spacing)
            
            path.addEllipse(in: CGRect(x: inset, y: inset, width: size.width - 2 * inset, height: size.height - 2 * inset))
        }
        
        return path
    }
    
    private func createSquarePath(in size: CGSize) -> Path {
        var path = Path()
        let squareSize: CGFloat = 20.0
        let numberOfSquares = 3
        let spacing: CGFloat = 10.0
        
        for i in 0..<numberOfSquares {
            let inset = CGFloat(i) * (squareSize + spacing)
            let rect = CGRect(x: inset, y: inset, width: size.width - 2 * inset, height: size.height - 2 * inset)
            path.addRoundedRect(in: rect, cornerSize: .init(width: 10, height: 10))
        }
        
        return path
    }
}

#Preview {
    VStack {
        SpaceProgressView()
    }
}
