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
            .font(userConfig.fontCategory.font)
            .background(userConfig.backgroundColor)
            .cornerRadius(userConfig.cornerRadius)
            .foregroundColor(userConfig.textColor)
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
    var fontCategory: FontCategory
    var icon: String?
    
    var animationEffect: Bool
    var animation: Animation
    var standardScale: CGFloat
    var animatedScale: CGFloat
    
    var width: CGFloat = 200
    var height: CGFloat = 50
    
    public static var space:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.spaceFont,
                textColor: SpaceColors.primary, backgroundColor: .clear,
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65
            )
    }
    
    public static var primary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.body,
                textColor: .primary,
                backgroundColor: .clear,
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1,
                borderColor: .clear
            )
    }
    
    public static var heading:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.heading,
                textColor: SpaceColors.primary,
                backgroundColor: .clear,
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1,
                borderColor: .clear
            )
    }
    
    public static var secondary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.body,
                textColor: SpaceColors.secondary,
                backgroundColor: .clear, cornerRadius: 10,
                shadow: false,
                borderWidth: 1,
                borderColor: .clear
            )
    }
    
    public static var tertiary:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.body,
                textColor: .orange.opacity(0.80),
                backgroundColor: .clear,
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1,
                borderColor: .clear
            )
    }
    
    public static var plain:
        SpaceLabelConfiguration {
            SpaceLabelConfiguration(
                fontCategory: FontCategory.body,
                textColor: SpaceColors.primary,
                backgroundColor: .clear,
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1,
                borderColor: .clear
            )
    }
    
    public init(
        fontCategory: FontCategory = FontCategory.body,
        textColor: Color = .primary,
        //Background
        backgroundColor: Color = .blue,
        cornerRadius: CGFloat = 10,
        shadow: Bool = false,
        borderWidth: CGFloat = 1,
        borderColor: Color = .clear,
        // Animation
        animationEffect: Bool = true,
        animation: Animation = .snappy(duration: 0.25),
        standardScale: CGFloat = 1.0,
        animatedScale: CGFloat = 0.65
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

