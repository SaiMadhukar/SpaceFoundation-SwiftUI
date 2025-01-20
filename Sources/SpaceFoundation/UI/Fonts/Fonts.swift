//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import Foundation
import SwiftUI

public enum FontCategory {
    
    private struct Constants {
        static let notoSans = "NotoSans-Regular"
        static let notoSansMedium = "NotoSans-Medium"
        static let notoSansSemiBold = "NotoSans-SemiBold"
        static let notoSansBold = "NotoSans-Bold"
        static let pacifico = "Pacifico-Regular"
        static let notoSherif = "NotoSerif-Bold"
    }
    
    case pageTitle
    case heading, headingSmall, headingLarge, headingXLarge, headingXXLarge
    case subheading, subHeadingMedium, subheadingLarge, subHeadingXLarge
    case body, caption, bodyMedium, bodyLarge, bodyXLarge
    case button, primaryButton, secondaryButton, tertiaryButton
    case link
    case spaceFont
    case amountField
    
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
        case .spaceFont:
            return 30
        case .amountField:
            return 96
        }
    }
    
    public var fontColor: Color {
        switch self {
        case .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle, .headingSmall, .amountField:
            return .primary
        case .subheading, .subHeadingMedium, .subheadingLarge, .subHeadingXLarge:
            return .secondary
        case .caption:
            return .secondary
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return .primary
        case .button, .primaryButton, .secondaryButton, .tertiaryButton:
            return .primary
        case .spaceFont:
            return .primary
        case .link:
            return .green.opacity(0.75)
        }
    }
    
    public var font: Font {
        switch self {
        case .headingSmall, .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle:
            return Font.custom(Constants.notoSansBold, size: size)
        case .subheading, .subHeadingMedium, .subheadingLarge, .subHeadingXLarge:
            return Font.custom(Constants.notoSansSemiBold, size: size)
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return Font.custom(Constants.notoSans, size: size)
        case .spaceFont:
            return Font.custom(Constants.pacifico, size: size)
        case .amountField:
            return Font.custom(Constants.notoSherif, size: size)
        default:
            return Font.custom(Constants.notoSans, size: size)
        }
    }
}

#Preview {
    VStack {
        SpaceLabel(title: "Space Foundation", configuration: .primary)
        SpaceLabel(title: "Space Foundation", configuration: .secondary)
        
        SpaceLabel(title: "Space Foundation", configuration: .space)
    }
}
