//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/14/24.
//


import SwiftUI

extension Shape {
    /// fills and strokes a shape
    public func fill<S:ShapeStyle>(
        _ fillContent: S,
        strokeColor: Color,
        stroke : StrokeStyle,
        showShadow: Bool = false,
        shadowRadius: CGFloat = 5,
        shadowColor: Color = .black
    ) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(strokeColor, style: stroke)
            
            if showShadow {
                self.shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 0)
            }
        }
    }
    
    public func fill<S:ShapeStyle>(
        _ fillContent: S,
        strokeGradient: LinearGradient,
        stroke : StrokeStyle,
        showShadow: Bool = false,
        shadowRadius: CGFloat = 5,
        shadowColor: Color = .black
    ) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(strokeGradient, style: stroke)
            
            if showShadow {
                self.shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 0)
            }
        }
    }
    
    public func fill<S:ShapeStyle>(
        _ fillContent: S,
        strokeGradient: AngularGradient,
        stroke : StrokeStyle,
        showShadow: Bool = false,
        shadowRadius: CGFloat = 5,
        shadowColor: Color = .black
    ) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(strokeGradient, style: stroke)
            
            if showShadow {
                self.shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 0)
            }
        }
    }
}
