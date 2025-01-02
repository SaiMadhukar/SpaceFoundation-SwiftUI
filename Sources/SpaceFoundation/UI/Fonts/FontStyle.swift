//
//  FontStyle.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/21/24.
//

import SwiftUI

public struct FontStyleModifier: ViewModifier {
    
    private var category: FontCategory
    private var weight: Font.Weight
    private var color: Color
    
    public init(category: FontCategory = .body, weight: Font.Weight = .regular, color: Color = .clear) {
        self.category = category
        self.weight = weight
        self.color = color == .clear ? category.fontColor : color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(category.font)
            .fontWeight(weight)
            .foregroundColor(color)
    }
}

extension View {
    
    public func spaceFontStyle(category: FontCategory = .body,
                               weight: Font.Weight = .regular,
                               color: Color = .clear) -> some View {
        self.modifier(FontStyleModifier(category: category, weight: weight, color: color))
    }
}


#Preview {
    VStack {
        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            .modifier(FontStyleModifier(category: .headingLarge, weight: .bold))
        
        Divider()
        
        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            .modifier(FontStyleModifier(category: .subheading, weight: .bold))
        
        Divider()
        
        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            .modifier(FontStyleModifier(category: .bodyMedium, weight: .bold))
        
        Divider()
        
        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            .modifier(FontStyleModifier(category: .spaceFont, weight: .regular))
    }
}
