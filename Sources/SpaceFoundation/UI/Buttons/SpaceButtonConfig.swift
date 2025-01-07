//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import SwiftUI

public struct SpaceButtonConfiguration {
    
    var cornerRadius: CGFloat
    var shadow: Bool
    var borderWidth: CGFloat
    var borderColor: Color
    var backgroundColor: Color
    var textColor: Color
    var fontCategory: FontCategory
    
    var animationEffect: Bool
    var animation: Animation
    var standardScale: CGFloat
    var animatedScale: CGFloat
    
    var width: CGFloat = 250
    var height: CGFloat = 50
    
    public static var primary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 24,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: SpaceColors.blue100,
                textColor: SpaceColors.primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                fontCategory: FontCategory.body
            )
    }
    
    public static var green:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 24,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: SpaceOpacity.o75.color(.green),
                textColor: SpaceColors.primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                fontCategory: .subHeadingMedium
            )
    }
    
    public static var secondary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 24,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: SpaceColors.blue100,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                fontCategory: FontCategory.body
            )
    }
    
    public static var tertiary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 24,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .black.opacity(0.45),
                textColor: .white,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                fontCategory: FontCategory.body
            )
    }
    
    public static var plain:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 24,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: SpaceColors.primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 1.2,
                fontCategory: FontCategory.body
            )
    }
    
    public init(
        cornerRadius: CGFloat = 24,
        shadow: Bool = false,
        borderWidth: CGFloat = 1,
        borderColor: Color = .clear,
        backgroundColor: Color = .blue,
        textColor: Color = .primary,
        animationEffect: Bool = true,
        animation: Animation = .snappy(duration: 0.25),
        standardScale: CGFloat = 1.0,
        animatedScale: CGFloat = 0.65,
        fontCategory: FontCategory = .body
    ) {
        self.cornerRadius = cornerRadius
        self.shadow = shadow
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.animationEffect = animationEffect
        self.animation = animation
        self.standardScale = standardScale
        self.animatedScale = animatedScale
        self.fontCategory = fontCategory
    }
}
