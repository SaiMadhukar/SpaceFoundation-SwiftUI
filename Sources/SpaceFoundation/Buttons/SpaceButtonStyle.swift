//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/13/24.
//

import Foundation
import SwiftUI

public struct SpaceButtonStyle: ButtonStyle {
    
    @State private var isPressed = false
    @State var userConfig: SpaceButtonConfiguration
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(userConfig.textColor)
            .font(userConfig.font)
            .background(userConfig.backgroundColor)
            .cornerRadius(userConfig.cornerRadius)
            .scaleEffect(isPressed && userConfig.animationEffect ? userConfig.animatedScale : userConfig.standardScale)
            .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
                withAnimation(userConfig.animation) {
                    isPressed = pressing
                }
            }, perform: {})
    }
}
