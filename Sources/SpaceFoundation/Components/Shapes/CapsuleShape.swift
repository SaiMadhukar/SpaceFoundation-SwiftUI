//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation
import SwiftUI

public struct Capsule: Shape {
    
    public func path(in rect: CGRect) -> Path {
        return Path(roundedRect: rect, cornerRadius: rect.height / 2)
    }
}

public struct Circle: Shape {
    public func path(in rect: CGRect) -> Path {
        return Path(roundedRect: rect, cornerRadius: rect.width + rect.height / 2)
    }
}

public struct CircleStyle: ShapeStyle {
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        if environment.colorScheme == .light {
            return Color.blue
        } else {
            return Color.red
        }
    }
}


public struct CapsuleButton: View {
    
    private var title: String
    private var action: (() -> Void)?
    @State var clickedState: Bool = false
    private var color: Color?
    private var gradient: SpaceGradient?
    private var fontCategory: FontCategory
    
    public init(
        title: String,
        fontCategory: FontCategory = .body,
        fillColor: Color? = nil,
        fillGradient: SpaceGradient? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.action = action
        self.color = fillColor
        self.gradient = fillGradient
        self.fontCategory = fontCategory
    }
    
    public var body: some View {
        if gradient != nil {
            gradientCirlce
        } else {
            plainCirlce
        }
    }
    
    private var plainCirlce: some View {
        Circle()
            .fill(color ?? .blue)
            .scaleEffect(clickedState ? 1.25 : 1)
            .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
                withAnimation(.snappy(duration: 0.25)) {
                    clickedState = pressing
                }
                action?()
            }, perform: {})
            .overlay(
                Text(title)
                    .textStyle(
                        fontCategory,
                        weight: .semibold
                    )
                    .scaleEffect(clickedState ? 1.1 : 1)
            )
    }
    
    private var gradientCirlce: some View {
        Circle()
            .fill(gradient?.lStyle() ?? SpaceGradient.purpleBlueLinear.lStyle())
            .scaleEffect(clickedState ? 1.25 : 1)
            .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
                withAnimation(.snappy(duration: 0.25)) {
                    clickedState = pressing
                }
                action?()
            }, perform: {})
            .overlay(
                Text(title)
                    .textStyle(
                        fontCategory,
                        weight: .semibold
                    )
                    .scaleEffect(clickedState ? 1.1 : 1)
            )
    }
}


#Preview {
    CapsuleButton(title: "Good2", fontCategory: .body) {
        print("Good2")
    }
    .frame(width: 100, height: 100)
}
