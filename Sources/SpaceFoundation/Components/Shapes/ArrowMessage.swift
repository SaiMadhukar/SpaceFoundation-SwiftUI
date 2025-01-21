//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/20/25.
//

import Foundation
import SwiftUI
import SwiftUICore

public enum ArrowDirection {
    case left, right
}

public struct ArrowMessage<V: View>: View {
    
    private var width: CGFloat
    private var height: CGFloat
    private var triangleHeight: CGFloat
    private var triangleWidth: CGFloat
    private var rect: CGRect
    private var direction: ArrowDirection
    private var padding: CGFloat = 5
    
    var label: () -> V
    
    public init(
        @ViewBuilder label: @escaping () -> V,
        width: CGFloat = 200,
        height: CGFloat = 100,
        direction: ArrowDirection = .right
    ) {
        self.label = label
        self.width = width
        self.height = height
        self.triangleHeight = height / 4
        self.triangleWidth = width / 4
        self.rect = CGRect(x: 0, y: triangleHeight, width: width, height: height - triangleHeight)
        self.direction = direction
    }
    
    public var body: some View {
        contentView
            .frame(width: width, height: height)
            .overlay(
                label()
                    .padding(.top, triangleHeight)
            )
    }
    
    
    var contentView: some View {
        Path { path in
            
            if direction == .left {
                path.move(to: CGPoint(x: triangleWidth / 2 + padding, y: 0))
                path.addLine(to: CGPoint(x: padding, y: triangleHeight))
                path.addLine(to: CGPoint(x: triangleWidth + padding, y: triangleHeight))
                
                
            } else {
                // Top Edge
                path.move(to: CGPoint(x: (width - triangleWidth / 2) - padding, y: 0))
                // Left edge
                path.addLine(to: CGPoint(x: (width - triangleWidth) - padding, y: triangleHeight))
                // Right Edge
                path.addLine(to: CGPoint(x: width - padding, y: triangleHeight))

            }
            
            path.addRoundedRect(in: self.rect, cornerSize: .init(width: 8, height: 8))
        
            path.closeSubpath()
        }
        .fill(Color.black.opacity(0.10))
    }
}

#Preview {
    
    HStack {
        ArrowMessage(label: {
            Text("20")
                .font(.body)
        }, width: 100, height: 50, direction: .left)
        
        Spacer()
        
        ArrowMessage(label: {
            Text("2000")
                .font(.body)
        }, width: 100, height: 50, direction: .right)
    }
    .padding(.horizontal, 16)
}
