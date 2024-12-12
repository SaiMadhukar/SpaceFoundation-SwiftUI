//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import SwiftUI

public struct SpaceLabelStyle: LabelStyle {
    
    @State private var action = false
    @State var userConfig: SpaceLabelConfiguration
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .padding()
            .frame(width: userConfig.width, height: userConfig.height)
            .foregroundColor(userConfig.textColor)
            .font(userConfig.font)
            .background(userConfig.backgroundColor)
            .cornerRadius(userConfig.cornerRadius)
            .scaleEffect(action && userConfig.animationEffect ? userConfig.animatedScale : userConfig.standardScale)
            .onAppear {
                action = true
            }
    }
}

public struct SpaceLabelConfiguration {
    
    var cornerRadius: CGFloat
    var shadow: Bool
    var borderWidth: CGFloat
    var borderColor: Color
    var backgroundColor: Color
    var textColor: Color
    var font: Font
    var icon: String?
    
    var animationEffect: Bool
    var animation: Animation
    var standardScale: CGFloat
    var animatedScale: CGFloat
    
    var width: CGFloat = 200
    var height: CGFloat = 50
    
    public static var primary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: .primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.body.font
            )
    }
    
    public static var secondary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: Color.secondary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.body.font
            )
    }
    
    public static var tertiary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: .orange.opacity(0.80),
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.body.font
            )
    }
    
    public static var plain:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .clear,
                textColor: .primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 1.2,
                font: FontCategory.headingLarge.font
            )
    }
    
    public init(
        cornerRadius: CGFloat = 10,
        shadow: Bool = false,
        borderWidth: CGFloat = 1,
        borderColor: Color = .clear,
        backgroundColor: Color = .blue,
        textColor: Color = .primary,
        animationEffect: Bool = true,
        animation: Animation = .snappy(duration: 0.25),
        standardScale: CGFloat = 1.0,
        animatedScale: CGFloat = 0.65,
        font: Font = Font.system(size: 22, weight: .bold)
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
        self.font = font
    }
}

