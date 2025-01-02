//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/21/24.
//

import Foundation
import SwiftUICore

extension Text {
    
    @MainActor public func textStyle(_ textStyle: FontCategory, weight: Font.Weight = .regular, color: Color = .clear) -> some View {
        self.modifier(FontStyleModifier(category: textStyle, weight: weight, color: color))
    }
}

final public class SpecialText {
    
    private var container: AttributeContainer
    
    public init(
        font: Font = .body,
        foregroundColor: Color = .primary,
        backgroundColor: Color = .clear,
        underline: Bool = false
    ) {
        var container = AttributeContainer()
        container.foregroundColor = foregroundColor
        container.backgroundColor = backgroundColor
        container.underlineColor = underline == false ? Color.clear.UiColor : Color.primary.UiColor
        container.font = font
        
        self.container = container
    }
    
    public func value(_ text: String) -> AttributedString {
        var attributedString = AttributedString(stringLiteral: text)
        attributedString.mergeAttributes(container)
        return attributedString
    }
}
