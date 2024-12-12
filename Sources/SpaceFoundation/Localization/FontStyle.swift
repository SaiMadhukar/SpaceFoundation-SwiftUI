//
//  FontStyle.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/21/24.
//

import SwiftUI

public enum FontCategory {
    case pageTitle
    case heading, headingSmall, headingLarge, headingXLarge, headingXXLarge
    case subheading, subHeadingMedium, subheadingLarge, subHeadingXLarge
    case body, caption, bodyMedium, bodyLarge, bodyXLarge
    case button, primaryButton, secondaryButton, tertiaryButton
    case link
    
    public var size: CGFloat {
        switch self {
        case .pageTitle:
            return 32
        case .headingSmall:
            return 18
        case .heading:
            return 20
        case .headingLarge:
            return 22
        case .headingXLarge:
            return 24
        case .headingXXLarge:
            return 28
        case .subheading, .subHeadingXLarge:
            return 14
        case .subheadingLarge:
            return 18
        case .subHeadingMedium:
            return 16
        case .caption:
            return 12
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return 16
        case .button, .primaryButton, .secondaryButton, .tertiaryButton:
            return 16
        case .link:
            return 14
        }
    }
    
    public var fontColor: Color {
        switch self {
        case .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle, .headingSmall:
            return .primary
        case .subheading, .subHeadingMedium, .subheadingLarge, .subHeadingXLarge:
            return .secondary
        case .caption:
            return .secondary
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return .primary
        case .button, .primaryButton, .secondaryButton, .tertiaryButton:
            return .primary
        case .link:
            return .green.opacity(0.75)
        }
    }
    
    public var font: Font {
        switch self {
            
        case .headingSmall, .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle:
            return Font.system(.title3)
        default:
            return Font.system(.largeTitle)
        }
    }
}

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
            .font(.system(size: category.size, weight: weight))
            .foregroundColor(color)
    }
}
