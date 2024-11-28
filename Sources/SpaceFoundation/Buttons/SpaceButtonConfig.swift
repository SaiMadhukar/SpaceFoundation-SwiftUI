//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import Foundation

public struct SpaceButtonDefaults {
    
    public static var primary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .blue.opacity(0.55),
                textColor: .white,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.headingLarge.font
            )
    }
    
    public static var secondary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .green.opacity(0.55),
                textColor: .primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.headingLarge.font
            )
    }
    
    public static var tertiary:
        SpaceButtonConfiguration {
            .init(
                cornerRadius: 10,
                shadow: false,
                borderWidth: 1, borderColor: .clear,
                backgroundColor: .black.opacity(0.45),
                textColor: .primary,
                animationEffect: true,
                animation: .snappy(duration: 0.25),
                standardScale: 1.0,
                animatedScale: 0.65,
                font: FontCategory.headingLarge.font
            )
    }
    
    public static var plain:
        SpaceButtonConfiguration {
            .init(
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
}
