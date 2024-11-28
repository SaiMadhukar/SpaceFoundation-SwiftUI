//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/10/24.
//

import SwiftUI

public struct SpaceButtonConfiguration {
    
    var cornerRadius: CGFloat
    var shadow: Bool
    var borderWidth: CGFloat
    var borderColor: Color
    var backgroundColor: Color
    var textColor: Color
    var font: Font
    
    var animationEffect: Bool
    var animation: Animation
    var standardScale: CGFloat
    var animatedScale: CGFloat
    
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





public struct SpaceButton: View {
    
    @State private var title: String
    @State private var action: () -> Void
    @State private var cornerRadius: CGFloat = 10
    @State private var configuration: SpaceButtonConfiguration
    
    public init(title: String,
                configuration: SpaceButtonConfiguration = SpaceButtonDefaults.primary,
                action: @escaping () -> Void) {
        _title = State(initialValue: title)
        self.action = action
        self.configuration = configuration
    }
    
    public var body: some View {
        Button(title, action: {
           action()
        })
        .buttonStyle(SpaceButtonStyle(userConfig: configuration))
        .frame(width: 200, height: 30)
    }
}

#Preview {
    ZStack {
        VStack(spacing: 32) {
            SpaceButton(title: "Submit", configuration: SpaceButtonDefaults.primary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: SpaceButtonDefaults.secondary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: SpaceButtonDefaults.tertiary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: SpaceButtonDefaults.plain) {
                print("Submit")
            }
            .padding(.bottom, 16)
        }
    }
    .frame(width: 400, height: 900)
    .background(Color.linearGradient)
}
